//
//  LabelTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 06/08/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit
import DZNEmptyDataSet

// MARK: CellIdentifiers
private let LabelCellIdentifier = "label"

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance

// MARK: UISearchController
private let ScopeButtons = ["Title", "Label", "Milestone"]

class LabelTableViewController: UITableViewController {
  
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
extension LabelTableViewController: Setup {
  
  func setupLocalization() {
    self.title = "__ADD_LABELS__".localized
  }
}

// MARK: - UITableView data source
extension LabelTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.repository.labels.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier(LabelCellIdentifier, forIndexPath: indexPath) as! LabelTableViewCell
    
    cell.repository = self.repository
    
    cell.repositoryNameLabel.text = cell.repository.labels[indexPath.row].name
    
    return cell
  }
}

// MARK: - UITableView delegate
extension LabelTableViewController { }

// MARK: - DZNEmptyDataSetSource
extension LabelTableViewController: DZNEmptyDataSetSource {
  
  func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
    let GitHubSmall = "github_small"
    
    return UIImage(named: GitHubSmall)!
  }
  
  func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
    return NSAttributedString(string: "__NO_LABELS__".localized)
  }
}

// MARK: - DZNEmptyDataSetDelegate
extension LabelTableViewController: DZNEmptyDataSetDelegate { }

// MARK: - Actions
extension LabelTableViewController { }

private extension LabelTableViewController {
  
  func setupEmptyDataSet() {
    self.tableView.emptyDataSetSource = self
    self.tableView.emptyDataSetDelegate = self
    
    // Removes cell seperators.
    self.tableView.tableFooterView = UIView()
  }
}