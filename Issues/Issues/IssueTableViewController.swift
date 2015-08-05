//
//  IssueTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import OAuthSwift
import DZNEmptyDataSet
import IssueKit

// MARK: CellIdentifiers
private let IssueCellIdentifier = "issue"

// MARK: SegueIdentifiers
private let ShowIssueOverview = "showIssueOverview"
private let ShowAddIssue = "showAddIssue"

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance

// MARK: UISearchController
private let ScopeButtons = ["Title", "Label", "Milestone"]

private let TitleSearch = 0
private let LabelSearch = 1
private let MilestoneSearch = 2

class IssueTableViewController: UITableViewController {
  
  private var issues: [Issue] = []
  private var filteredIssues: [Issue] = []
  private var searchController: UISearchController?
  
  private var destionationViewController: UIViewController?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let oauthswift = OAuth2Swift(
      consumerKey: ClientID,
      consumerSecret: ClientSecret,
      authorizeUrl: "https://github.com/login/oauth/authorize",
      accessTokenUrl: "https://github.com/login/oauth/access_token",
      responseType: "code")
    
    let state = generateState(20)
    oauthswift.authorizeWithCallbackURL(NSURL(string: "nl.basbroek.issues:/oauth-callback/github")!, scope: "user,repo", state: state, success: {
      credential, response, parameters in
        print("token: \(credential.oauth_token)")
      }, failure: {
      error in
        print("Error auth: \(error.localizedDescription)")
    })
    
    self.setupLocalization()
    self.setupAutomaticCellResizing()
    self.setupRefresh()
    self.setupSearch()
    
    self.setupEmptyDataSet()
    
    Request.delegate = self
    self.navigationController?.delegate = self
    
    Request.requestUserIssues(IssueParameterOptions(state: Value.State.Open.stringValue))
  }
}

// MARK: - Setup
extension IssueTableViewController: Setup {
  
  func setupRefresh() {
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: Selector("refresh"), forControlEvents: .ValueChanged)
    
    self.refreshControl = refresh
  }
  
  func setupSearch() {
    self.searchController = UISearchController(searchResultsController: nil)
    self.searchController?.searchBar.delegate = self
    
    self.searchController?.dimsBackgroundDuringPresentation = false
    self.searchController?.searchBar.scopeButtonTitles = [] //ScopeButtons
    
    self.tableView.tableHeaderView = self.searchController?.searchBar
  }
  
  func setupLocalization() {
    self.title = "__ISSUES__".localized
  }
}

// MARK: - RequestDelegate
extension IssueTableViewController: RequestDelegate {
  
  /// Refreshes the list of shown issues.
  ///
  /// - Parameter issues: issues to use in refresh
  func refresh(issues: [Issue]) {
    if self.issues.isEmpty {
      self.issues += issues
      self.filteredIssues = self.issues
      
      self.tableView.reloadData()
    } else {
      let now = self.issues.flatMap { $0 as? GitHubIssue }
      let new = issues.flatMap { $0 as? GitHubIssue }
      
      let addIssues = new.filter { !now.contains($0) }.map { $0 as Issue }
      let removeIssues = now.filter { !new.contains($0) }.map { $0 as Issue }
      
      guard removeIssues.count != 0 || addIssues.count != 0 else { return }
      
      let ids = self.issues.map { $0.id }
      
      for i in removeIssues {
        if let idx = ids.indexOf(i.id) {
          self.issues.removeAtIndex(idx)
        }
      }
      
      self.issues.splice(addIssues, atIndex: 0)
      
      self.tableView.reloadData()
    }
  }
  
  func refresh(issue: Issue, labels: Set<Label>) {
    print("refreshed \(issue) w/ labels \(labels)")
  }
}

// MARK: - Refreshing
extension IssueTableViewController {
  
  func refresh() {
    Request.delegate = self
    Request.requestUserIssues(IssueParameterOptions(state: Value.State.Open.stringValue))
  }
}

// MARK: - UISearchBarDelegate
extension IssueTableViewController: UISearchBarDelegate {
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    let selectedScope = searchBar.selectedScopeButtonIndex
    
    self.search(selectedScope, text: searchText)
  }
  
  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    guard let text = searchBar.text else { return }
    
    self.search(selectedScope, text: text)
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    self.reloadData()
  }
}

// MARK: - Searchable
extension IssueTableViewController: Searchable {
  
  func search(searchType: Int, text: String) {
    func resetSearch() {
      self.filteredIssues = self.issues
      self.tableView.reloadData()
    }
    
    guard !text.isEmpty else { resetSearch(); return }
    
    switch(searchType) {
    default:
      self.filteredIssues = self.issues.filter { $0.title.contains(text) }
    }
    
    self.tableView.reloadData()
  }
}

// MARK: - UITableView data source
extension IssueTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let searchController = self.searchController where searchController.active {
      return self.filteredIssues.count
    }
    
    return self.issues.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier(IssueCellIdentifier, forIndexPath: indexPath) as! IssueTableViewCell
    
    if let searchController = self.searchController where searchController.active {
      cell.issue = self.filteredIssues[indexPath.row]
    } else {
      cell.issue = self.issues[indexPath.row]
    }
    
    cell.issueTitleLabel.text = cell.issue.title
    
    let issueStateIcon: FAType?
    
    switch(cell.issue.state) {
    case .Open:
      issueStateIcon = FAType.FACheck
      cell.issueStateIconLabel.textColor = .gitHubRedColor()
    case .Closed:
      issueStateIcon = FAType.FAExclamationCircle
      cell.issueStateIconLabel.textColor = .gitHubGreenColor()
    }
    
    cell.issueStateIconLabel.FAIcon = issueStateIcon
    
    return cell
  }
}

// MARK: - UITableView delegate
extension IssueTableViewController { }

// MARK: - DZNEmptyDataSetSource
extension IssueTableViewController: DZNEmptyDataSetSource {
  
  func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
    let GitHub = "github"
    
    return UIImage(named: GitHub)!
  }
  
  func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
    return NSAttributedString(string: "__ISSUES_ARE_LOADING__".localized)
  }
}

// MARK: - DZNEmptyDataSetDelegate
extension IssueTableViewController: DZNEmptyDataSetDelegate { }

// MARK: - Actions
extension IssueTableViewController { }

// MARK: - Navigation
extension IssueTableViewController: UINavigationControllerDelegate {
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    var issueTableViewController: IssueOverviewTableViewController!
    
    if segue.identifier == ShowIssueOverview {
      if let issueNavigationController = segue.destinationViewController as? UINavigationController {
        issueTableViewController = issueNavigationController.topViewController as? IssueOverviewTableViewController
        issueTableViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        issueTableViewController.navigationItem.leftItemsSupplementBackButton = true
      } else {
        issueTableViewController = segue.destinationViewController as? IssueOverviewTableViewController
      }
      
      if let cell = sender as? IssueTableViewCell,
       let issue = cell.issue {
        issueTableViewController.issue = issue
        
        self.splitViewController?.toggleMasterView(self.searchController)
      }
    }
  }
  
  func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
    guard viewController == self.destionationViewController else { return }
    
    self.reloadData()
  }
}

private extension IssueTableViewController {
  
  func reloadData() {
    self.filteredIssues = self.issues
    self.tableView.reloadData()
  }
  
  func setupEmptyDataSet() {
    self.tableView.emptyDataSetSource = self
    self.tableView.emptyDataSetDelegate = self
    
    // Removes cell seperators.
    self.tableView.tableFooterView = UIView()
  }
}