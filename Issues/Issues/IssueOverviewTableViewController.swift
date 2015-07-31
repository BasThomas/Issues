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
  
  @IBOutlet weak var issueTitleLabel: UILabel! {
    didSet {
      self.issueTitleLabel.text = issue.title
    }
  }
  
  @IBOutlet weak var issueAssigneeLabel: UILabel! {
    didSet {
      self.issueAssigneeLabel.text = issue.assignee?.name ?? "no assignee set"
    }
  }
  
  @IBOutlet weak var issueLabelsLabel: UILabel! {
    didSet {
      self.issueLabelsLabel.text = "labels: \(issue.labels.count)"
    }
  }
  
  @IBOutlet weak var issueMilestoneLabel: UILabel! {
    didSet {
      self.issueMilestoneLabel.text = issue.milestone?.title ?? "no milestone set"
    }
  }
  
  var issue: Issue!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(issue)
    
    self.setupLocalization()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - Setup
extension IssueOverviewTableViewController: Setup {
  
  func setupLocalization() {
    let localized = "__ISSUE__".localized
    
    let localizedTitle = "\(localized) #\(issue.number) (\(self.issue.repository.name))"
    
    self.title = localizedTitle
  }
}

// MARK: - UITableView delegate
extension IssueOverviewTableViewController {
  
  // Setup automatic cell resizing. Seems you need to do so per indexPath in a static tableview.
  override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 44
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
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