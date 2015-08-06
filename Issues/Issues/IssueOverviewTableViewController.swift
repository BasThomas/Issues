//
//  IssueOverviewTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import Haneke
import DZNEmptyDataSet
import IssueKit

// MARK: SegueIdentifiers

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance
private let Parse = ParseController.sharedInstance

private let LastSelectedIssue = "lastSelectedIssue"

class IssueOverviewTableViewController: UITableViewController {
  
  @IBOutlet weak var issueTitleLabel: UILabel! {
    didSet {
      self.issueTitleLabel.text = issue?.title
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
      self.issueAssigneeLabel.text = issue?.assignee?.name
    }
  }
  
  @IBOutlet weak var issueLabelsLabel: UILabel! {
    didSet {
      var labelText = ""
      
      if let issue = self.issue {
        labelText = ", ".join(issue.labels.map { $0.name } )
      }
      
      guard !labelText.isEmpty else { return }
      
      self.issueLabelsLabel.text = labelText
      if let firstIssue = issue?.labels.first {
        self.issueLabelsLabel.textColor = firstIssue.hex.color
      }
    }
  }
  
  @IBOutlet weak var issueMilestoneLabel: UILabel! {
    didSet {
      self.issueMilestoneLabel.text = issue?.milestone?.title
    }
  }
  
  var issue: Issue?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupLocalization()
    self.setupEmptyDataSet()
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
      let repositoryName = issue.repository?.name ?? "uknown repository"
      
      let localizedTitle = "\(localized) #\(issue.number) (\(repositoryName))"
      
      self.title = localizedTitle
    } else {
      self.title = "__SELECT_AN_ISSUE__".localized
    }
    
    if self.issueTitleLabel.text == nil {
      self.issueTitleLabel.text = "__UNKNOWN_TITLE__".localized
    }
    
    if self.issueAssigneeLabel.text == nil {
      self.issueAssigneeLabel.text = "__NO_ASSIGNEE_SET__".localized
    }
    
    if self.issueLabelsLabel.text == nil {
      self.issueLabelsLabel.text = "__NO_LABELS_SET__".localized
    }
    
    if self.issueMilestoneLabel.text == nil {
      self.issueMilestoneLabel.text = "__NO_MILESTONE_SET__".localized
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

// MARK: - DZNEmptyDataSetSource
extension IssueOverviewTableViewController: DZNEmptyDataSetSource {
  
  func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
    let GitHubLarge = "github_large"
    
    return UIImage(named: GitHubLarge)!
  }
  
  func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
    return NSAttributedString(string: "__SELECT_AN_ISSUE__".localized)
  }
}

// MARK: - DZNEmptyDataSetDelegate
extension IssueOverviewTableViewController: DZNEmptyDataSetDelegate { }

// MARK: - Actions
extension IssueOverviewTableViewController { }

// MARK: - Navigation
extension IssueOverviewTableViewController {
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
}

private extension IssueOverviewTableViewController {
  
  func setupEmptyDataSet() {
    self.tableView.emptyDataSetSource = self
    self.tableView.emptyDataSetDelegate = self
  }
}