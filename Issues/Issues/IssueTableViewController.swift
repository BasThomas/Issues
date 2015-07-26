//
//  IssueTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit

private let Request = RequestController.sharedInstance
private let Parse = ParseController.sharedInstance

class IssueTableViewController: UITableViewController {
  
  private var issues: [Issue] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    Parse.delegate = self
    
    Request.requestIssues(IssueParameterOptions(state: Value.State.All.stringValue))
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

// MARK: - UITableView data source
extension IssueTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.issues.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("issue", forIndexPath: indexPath) as! IssueTableViewCell
    
    cell.issueTitleLabel.text = self.issues[indexPath.row].title
    
    return cell
  }
}

// MARK: - UITableView delegate
extension IssueTableViewController {
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

// MARK: - Navigation
extension IssueTableViewController {
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
}