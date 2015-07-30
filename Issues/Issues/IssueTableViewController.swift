//
//  IssueTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
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
    
    self.setupLocalization()
    self.setupAutomaticCellResizing()
    self.setupSearch()
    
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: Selector("refresh"), forControlEvents: .ValueChanged)
    
    self.refreshControl = refresh
    
    Request.delegate = self
    self.navigationController?.delegate = self
    
    Request.requestUserIssues(IssueParameterOptions(state: Value.State.Open.stringValue))
  }
}

// MARK: - Setup
extension IssueTableViewController: Setup {
  
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
      
      let newIssues = new.filter { !now.contains($0) }.map { $0 as Issue }
      let removeIssues = now.filter { !new.contains($0) }.map { $0 as Issue }
      
      print("should add \(newIssues)")
      print("should remove \(removeIssues)")
      
      guard removeIssues.count != 0 || newIssues.count != 0 else { return }
      
//      self.issues.removeObjects(removeIssues)
      self.issues.splice(newIssues, atIndex: 0)
      
      self.tableView.beginUpdates()
      let indexPaths = newIndexPaths(now: now.count, add: newIssues.count)
      self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Middle)
      self.tableView.endUpdates()
    }
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
extension IssueTableViewController {
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

// MARK: - Actions
extension IssueTableViewController { }

// MARK: - Navigation
extension IssueTableViewController: UINavigationControllerDelegate {
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard segue.identifier == ShowIssueOverview else { return }
    
    if segue.identifier == ShowIssueOverview,
       let dvc = segue.destinationViewController as? IssueOverviewTableViewController,
       let cell = sender as? IssueTableViewCell, let issue = cell.issue {
        
      if let searchController = self.searchController where searchController.active {
        searchController.active = false
      }
      
      self.destionationViewController = dvc
      dvc.issue = issue
    } else if segue.identifier == ShowAddIssue,
       let dvc = segue.destinationViewController as? AddIssueTableViewController {
      self.destionationViewController = dvc
    }
  }
  
  func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
    guard viewController == self.destionationViewController else { return }
    
    if let viewController = viewController as? AddIssueTableViewController {
      viewController.titleTextField.becomeFirstResponder()
    }
    
    self.filteredIssues = self.issues
    self.tableView.reloadData()
  }
}