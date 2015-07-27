//
//  IssueOverviewTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit

// MARK: CellIdentifiers
private let CellIdentifier = "cell"

// MARK: SegueIdentifiers

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance
private let Parse = ParseController.sharedInstance

class IssueOverviewTableViewController: UITableViewController {
  
  var issue: Issue!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(issue)
    
    self.tableView.registerClass(IssueOverviewTableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - UITableView data source
extension IssueOverviewTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! IssueOverviewTableViewCell
    
    return cell
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