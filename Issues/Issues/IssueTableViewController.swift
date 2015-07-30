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

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance

class IssueTableViewController: UITableViewController {
  
  private var issues: [Issue] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupLocalization()
    self.setupAutomaticCellResizing()
    
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: Selector("refresh"), forControlEvents: .ValueChanged)
    
    self.refreshControl = refresh
    
    Request.delegate = self
    
    Request.requestUserIssues(IssueParameterOptions(state: Value.State.Open.stringValue))
  }
}

// MARK: - Setup
extension IssueTableViewController: Setup {
  
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

// MARK: - UITableView data source
extension IssueTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.issues.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier(IssueCellIdentifier, forIndexPath: indexPath) as! IssueTableViewCell
    
    cell.issue = self.issues[indexPath.row]
    
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
extension IssueTableViewController {
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard segue.identifier == ShowIssueOverview else { return }
    
    if let dvc = segue.destinationViewController as? IssueOverviewTableViewController,
       let cell = sender as? IssueTableViewCell, let issue = cell.issue {
      dvc.issue = issue
    }
  }
}