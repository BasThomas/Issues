//
//  IssueOverviewTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit

// MARK: SegueIdentifiers

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance
private let Parse = ParseController.sharedInstance

class IssueOverviewTableViewController: UITableViewController {
  
  var issue: Issue!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupLocalization()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - Setup
extension IssueOverviewTableViewController: Setup {
  
  func setupLocalization() {
    self.title = NSLocalizedString("__ISSUE_OVERVIEW__", comment: "Issue overview")
  }
}

// MARK: - UITableView delegate
extension IssueOverviewTableViewController {
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

// MARK: - Actions
extension IssueOverviewTableViewController { }

// MARK: - Navigation
extension IssueOverviewTableViewController {
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
}