//
//  IssueTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit

// MARK: CellIdentifiers
private let IssueCellIdentifier = "issue"

// MARK: SegueIdentifiers
private let ShowIssueOverview = "showIssueOverview"

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance
private let Parse = ParseController.sharedInstance

class IssueTableViewController: UITableViewController {
  
  private var issues: [Issue] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: Selector("refresh"), forControlEvents: .ValueChanged)
    
    self.refreshControl = refresh
    
    
    Parse.delegate = self
    
    Request.requestIssues(IssueParameterOptions(state: Value.State.All.stringValue, filter: Value.Sort.All))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - ParseDelegate
extension IssueTableViewController: ParseDelegate {
  
  func parsedIssues(issues: [Issue]) {
    self.issues += issues
    
    self.tableView.reloadData()
  }
}

// MARK: - Refreshing
extension IssueTableViewController {
  func refresh() {
    Request.requestUserIssues(IssueParameterOptions(state: Value.State.All.stringValue))
    self.refreshControl?.endRefreshing()
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
    
    cell.issueTitleLabel.text = cell.issue?.title
    
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