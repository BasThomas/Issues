//
//  IssueOverviewTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import Haneke
import IssueKit

// MARK: SegueIdentifiers

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance
private let Parse = ParseController.sharedInstance

private let LastSelectedIssue = "lastSelectedIssue"

class IssueOverviewTableViewController: UITableViewController {
  
  @IBOutlet weak var issueTitleLabel: UILabel! {
    didSet {
      self.issueTitleLabel.text = issue?.title ?? "unknown title"
    }
  }
  
  @IBOutlet weak var issueAssigneeImageView: UIImageView! {
    didSet {
      if let avatarURL = issue?.assignee?.avatarURL {
        self.issueAssigneeImageView.hnk_setImageFromURL(avatarURL)
      } else if let placeholder = UIImage(named: "GitHub") {
        self.issueAssigneeImageView.hnk_setImage(placeholder, key: "GitHub")
      }
      
      self.issueAssigneeImageView.layer.cornerRadius = (self.issueAssigneeImageView.frame.size.height / 2)
      self.issueAssigneeImageView.layer.masksToBounds = true
    }
  }
  
  @IBOutlet weak var issueAssigneeLabel: UILabel! {
    didSet {
      self.issueAssigneeLabel.text = issue?.assignee?.name ?? "no assignee set"
    }
  }
  
  @IBOutlet weak var issueLabelsLabel: UILabel! {
    didSet {
      var labelText = ""
      
      if let issue = self.issue {
        labelText = ", ".join(issue.labels.map { $0.name } )
      }
      
      let labelTextIsEmpty = labelText.isEmpty
      
      self.issueLabelsLabel.text = labelTextIsEmpty ? "no labels" : labelText
      if let firstIssue = issue?.labels.first {
        self.issueLabelsLabel.textColor = firstIssue.hex.color
      }
    }
  }
  
  @IBOutlet weak var issueMilestoneLabel: UILabel! {
    didSet {
      self.issueMilestoneLabel.text = issue?.milestone?.title ?? "no milestone set"
    }
  }
  
  var issue: Issue?
  
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
    let localized = "__ISSUE__".localized
    
    if let issue = self.issue {
      let localizedTitle = "\(localized) #\(issue.number) (\(issue.repository.name))"
      
      self.title = localizedTitle
    } else {
      self.title = "__SELECT_AN_ISSUE__".localized
    }
  }
}

// MARK: - UITableView delegate
extension IssueOverviewTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    if let _ = self.issue {
      return 1
    }
    
    return 0
  }
  
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