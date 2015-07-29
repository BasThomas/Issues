//
//  RepositoryTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 28/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit

// MARK: CellIdentifiers
private let RepositoryCellIdentifier = "repository"

// MARK: SegueIdentifiers

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance
private let Parse = ParseController.sharedInstance

protocol RepositoryDelegate {
  
  func repositoryChosen(repository: Repository)
  func repositoriesFetched(repositories: [Repository])
}

class RepositoryTableViewController: UITableViewController {
  
  var delegate: RepositoryDelegate?
  
  var repositories: [Repository] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupLocalization()
    self.setupAutomaticCellResizing()
    
    Request.delegate = self
    
    guard self.repositories.isEmpty else { return }
    
    Request.requestUserRepositories()
  }
}

// MARK: - Setup
extension RepositoryTableViewController: Setup {
  
  func setupLocalization() {
    self.title = "__CHOOSE_A_REPOSITORY__".localized
  }
}

// MARK: - RequestDelegate
extension RepositoryTableViewController: RequestDelegate {
  
  func refresh(issues: [Issue]) { }
  
  func refresh(repositories: [Repository]) {
    if self.repositories.isEmpty {
      self.repositories += repositories
      self.tableView.reloadData()
    } else {
      let now = self.repositories.flatMap { $0 as? GitHubRepository }
      let new = repositories.flatMap { $0 as? GitHubRepository }
      
      let newRepositories = new.filter { !now.contains($0) }.map { $0 as Repository }
      let removeRepositories = now.filter { !new.contains($0) }.map { $0 as Repository }
      
      print("should add \(newRepositories)")
      print("should remove \(removeRepositories)")
      
      guard removeRepositories.count != 0 || newRepositories.count != 0 else { return }
      
//      self.repositories.removeObjects(removeRepositories)
      self.repositories.splice(newRepositories, atIndex: 0)
      
      self.tableView.beginUpdates()
      let indexPaths = newIndexPaths(now: now.count, add: newRepositories.count)
      self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Middle)
      self.tableView.endUpdates()
    }
    
    self.delegate?.repositoriesFetched(self.repositories)
  }
}

// MARK: - UITableView data source
extension RepositoryTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.repositories.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier(RepositoryCellIdentifier, forIndexPath: indexPath) as! RepositoryTableViewCell
    
    cell.repository = self.repositories[indexPath.row]
    
    cell.nameLabel.text = cell.repository.fullName
    
    return cell
  }
}

// MARK: - UITableView delegate
extension RepositoryTableViewController {
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    self.delegate?.repositoryChosen(self.repositories[indexPath.row])
    self.navigationController?.popViewControllerAnimated(true)
  }
}

// MARK: - Actions
extension RepositoryTableViewController { }