//
//  RepositoryTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 28/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import Haneke
import Font_Awesome_Swift
import DZNEmptyDataSet
import IssueKit

// MARK: CellIdentifiers
private let RepositoryCellIdentifier = "repository"

// MARK: SegueIdentifiers

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance
private let Parse = ParseController.sharedInstance

// MARK: UISearchController
private let ScopeButtons = ["Full name", "Repository", "Owner"]

private let FullNameSearch = 0
private let RepositorySearch = 1
private let OwnerSearch = 2

protocol RepositoryDelegate {
  
  func repositoryChosen(repository: Repository)
  func repositoriesFetched(repositories: [Repository])
}

class RepositoryTableViewController: UITableViewController {
  
  var delegate: RepositoryDelegate?
  
  var repositories: [Repository] = []
  private var filteredRepositories: [Repository] = []
  private var searchController: UISearchController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupLocalization()
    self.setupAutomaticCellResizing()
    
    Request.delegate = self
    
    self.filteredRepositories = self.repositories
    self.setupSearch()
    self.setupEmptyDataSet()
    
    guard self.repositories.isEmpty else { return }
    
    Request.requestUserRepositories()
  }
}

// MARK: - Setup
extension RepositoryTableViewController: Setup {
  
  func setupSearch() {
    self.searchController = UISearchController(searchResultsController: nil)
    self.searchController?.searchBar.delegate = self
    
    self.searchController?.dimsBackgroundDuringPresentation = false
    self.searchController?.searchBar.scopeButtonTitles = ScopeButtons
    
    self.tableView.tableHeaderView = self.searchController?.searchBar
  }
  
  func setupLocalization() {
    self.title = "__CHOOSE_A_REPOSITORY__".localized
  }
}

// MARK: - RequestDelegate
extension RepositoryTableViewController: RequestDelegate {
  
  func refresh(repositories: [Repository]) {
    if self.repositories.isEmpty {
      self.repositories += repositories
      self.filteredRepositories = self.repositories
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

// MARK: - UISearchBarDelegate
extension RepositoryTableViewController: UISearchBarDelegate {
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    let selectedScope = searchBar.selectedScopeButtonIndex
    
    self.search(selectedScope, text: searchText)
  }
  
  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    guard let text = searchBar.text else { return }

    self.search(selectedScope, text: text)
  }
}

// MARK: - Searchable
extension RepositoryTableViewController: Searchable {
  
  func search(searchType: Int, text: String) {
    func resetSearch() {
      //      let now = self.filteredRepositories.flatMap { $0 as? GitHubRepository }
      //      print("now: \(now.count)")
      self.filteredRepositories = self.repositories
      //      let new = self.filteredRepositories.flatMap { $0 as? GitHubRepository }
      //      print("new: \(new.count)")
      //
      //      let newRepositories = new.filter { !now.contains($0) }.map { $0 as Repository }
      //      print("#new: \(newRepositories.count)")
      //
      //      self.tableView.beginUpdates()
      //      let indexPaths = newIndexPaths(now: now.count, add: newRepositories.count)
      //      self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Middle)
      //      self.tableView.endUpdates()
      self.tableView.reloadData()
    }
    
    guard !text.isEmpty else { resetSearch(); return }
    
    switch(searchType) {
    case FullNameSearch:
      self.filteredRepositories = self.repositories.filter { $0.fullName.contains(text) }
    case RepositorySearch:
      self.filteredRepositories = self.repositories.filter { $0.name.contains(text) }
    case OwnerSearch:
      self.filteredRepositories = self.repositories.filter { $0.owner.name.contains(text) }
    default:
      return
    }
    
    self.tableView.reloadData()
  }
}

// MARK: - UITableView data source
extension RepositoryTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let searchController = self.searchController where searchController.active {
      return self.filteredRepositories.count
    }
    
    return self.repositories.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let GitHubSmall = "github_small"
    let Fork = "fork"
    let PrivateRepository = "private_repository"
    
    let cell = self.tableView.dequeueReusableCellWithIdentifier(RepositoryCellIdentifier, forIndexPath: indexPath) as! RepositoryTableViewCell
    
    if let searchController = self.searchController where searchController.active {
      cell.repository = self.filteredRepositories[indexPath.row]
    } else {
      cell.repository = self.repositories[indexPath.row]
    }
    
    if let avatarURL = cell.repository.owner.avatarURL {
      cell.repositoryImageView.hnk_setImageFromURL(avatarURL)
      cell.repositoryImageView.layer.cornerRadius = (cell.repositoryImageView.frame.size.height / 2)
      cell.repositoryImageView.layer.masksToBounds = true
    } else if let placeholder = UIImage(named: GitHubSmall) {
      cell.repositoryImageView.hnk_setImage(placeholder, key: GitHubSmall)
    }
    
    if cell.repository.isFork {
      cell.repositoryIsForkImageView.hidden = false
    }
    
    if cell.repository.isPrivate,
     let privateRepository = UIImage(named: PrivateRepository) {
      cell.repositoryIsPrivateImageView.hnk_setImage(privateRepository, key: PrivateRepository)
    }
    
    cell.repositoryNameLabel.text = cell.repository.fullName
    
    return cell
  }
}

// MARK: - UITableView delegate
extension RepositoryTableViewController {
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    self.tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
    
    if let searchController = self.searchController where searchController.active {
      searchController.active = false
      self.delegate?.repositoryChosen(self.filteredRepositories[indexPath.row])
    } else {
      self.delegate?.repositoryChosen(self.repositories[indexPath.row])
    }
    
    self.navigationController?.popViewControllerAnimated(true)
  }
}

// MARK: - DZNEmptyDataSetSource
extension RepositoryTableViewController: DZNEmptyDataSetSource {
  
  func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
    let GitHubSmall = "github"
    
    return UIImage(named: GitHubSmall)!
  }
  
  func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
    return NSAttributedString(string: "__REPOSITORIES_ARE_LOADING__".localized)
  }
}

// MARK: - DZNEmptyDataSetDelegate
extension RepositoryTableViewController: DZNEmptyDataSetDelegate { }

// MARK: - Actions
extension RepositoryTableViewController { }

private extension RepositoryTableViewController {
  
  func setupEmptyDataSet() {
    self.tableView.emptyDataSetSource = self
    self.tableView.emptyDataSetDelegate = self
    
    // Removes cell seperators.
    self.tableView.tableFooterView = UIView()
  }
}