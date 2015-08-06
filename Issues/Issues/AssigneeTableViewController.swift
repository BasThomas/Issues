//
//  AssigneeTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 06/08/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit
import DZNEmptyDataSet

// MARK: CellIdentifiers
private let AssigneeCellIdentifier = "assignee"

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance

// MARK: UISearchController
private let ScopeButtons = ["Title", "Label", "Milestone"]

class AssigneeTableViewController: UITableViewController {
  
  var repository: Repository!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupLocalization()
    self.setupAutomaticCellResizing()
    
    self.setupEmptyDataSet()
//    self.navigationController?.delegate = self
  }
}

// MARK: - Setup
extension AssigneeTableViewController: Setup {
  
  func setupLocalization() {
    self.title = "__ADD_ASSIGNEE__".localized
  }
}

// MARK: - UITableView data source
extension AssigneeTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.repository.assignees.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier(AssigneeCellIdentifier, forIndexPath: indexPath) as! AssigneeTableViewCell
    
    cell.repository = self.repository
    let assignee = cell.repository.assignees[indexPath.row]
    
    if let avatarURL = assignee.avatarURL {
      cell.repositoryAssigneeImageView.hnk_setImageFromURL(avatarURL)
      cell.repositoryAssigneeImageView.layer.cornerRadius = (cell.repositoryAssigneeImageView.frame.size.height / 2)
      cell.repositoryAssigneeImageView.layer.masksToBounds = true
    }
    
    cell.repositoryAssigneeNameLabel.text = assignee.name
    
    return cell
  }
}

// MARK: - UITableView delegate
extension AssigneeTableViewController { }

// MARK: - DZNEmptyDataSetSource
extension AssigneeTableViewController: DZNEmptyDataSetSource {
  
  func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
    let GitHubSmall = "github_small"
    
    return UIImage(named: GitHubSmall)!
  }
  
  func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
    return NSAttributedString(string: "__NO_ASSIGNEES__".localized)
  }
}

// MARK: - DZNEmptyDataSetDelegate
extension AssigneeTableViewController: DZNEmptyDataSetDelegate { }

// MARK: - Actions
extension AssigneeTableViewController { }

private extension AssigneeTableViewController {
  
  func setupEmptyDataSet() {
    self.tableView.emptyDataSetSource = self
    self.tableView.emptyDataSetDelegate = self
    
    // Removes cell seperators.
    self.tableView.tableFooterView = UIView()
  }
}