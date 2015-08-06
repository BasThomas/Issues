//
//  MilestoneTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 06/08/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit
import DZNEmptyDataSet

// MARK: CellIdentifiers
private let MilestoneCellIdentifier = "milestone"

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance

// MARK: UISearchController
private let ScopeButtons = ["Title", "Label", "Milestone"]

class MilestoneTableViewController: UITableViewController {
  
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
extension MilestoneTableViewController: Setup {
  
  func setupLocalization() {
    self.title = "__ADD_MILESTONE__".localized
  }
}

// MARK: - UITableView data source
extension MilestoneTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.repository.milestones.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier(MilestoneCellIdentifier, forIndexPath: indexPath) as! MilestoneTableViewCell
    
    cell.repository = self.repository
    
    cell.repositoryMilestoneNameLabel.text = cell.repository.milestones[indexPath.row].title
    
    return cell
  }
}

// MARK: - UITableView delegate
extension MilestoneTableViewController { }

// MARK: - DZNEmptyDataSetSource
extension MilestoneTableViewController: DZNEmptyDataSetSource {
  
  func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
    let GitHubSmall = "github_small"
    
    return UIImage(named: GitHubSmall)!
  }
  
  func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
    return NSAttributedString(string: "__NO_MILESTONES__".localized)
  }
}

// MARK: - DZNEmptyDataSetDelegate
extension MilestoneTableViewController: DZNEmptyDataSetDelegate { }

// MARK: - Actions
extension MilestoneTableViewController { }

private extension MilestoneTableViewController {
  
  func setupEmptyDataSet() {
    self.tableView.emptyDataSetSource = self
    self.tableView.emptyDataSetDelegate = self
    
    // Removes cell seperators.
    self.tableView.tableFooterView = UIView()
  }
}