//
//  AddIssueTableViewController.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit

// MARK: Request + Parse instances
private let Request = RequestController.sharedInstance
private let Parse = ParseController.sharedInstance

// MARK: SegueIdentifiers
private let AddRepository = "addRepository"
private let AddLabel = "addLabel"
private let AddAssignee = "addAssignee"
private let AddMilestone = "addMilestone"

private let SelectTitle = 1
private let SelectBody = 2

private let TopIndexPath = NSIndexPath(forRow: 0, inSection: 0)

class AddIssueTableViewController: UITableViewController {
  
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  @IBOutlet weak var repositoryImageView: UIImageView! {
    didSet {
      let GitHubSmall = "github_small"
      
      if let placeholder = UIImage(named: GitHubSmall) {
        self.repositoryImageView.hnk_setImage(placeholder, key: GitHubSmall)
      }
      
      self.repositoryImageView.layer.cornerRadius = (self.repositoryImageView.frame.size.height / 2)
      self.repositoryImageView.layer.masksToBounds = true
    }
  }
  @IBOutlet weak var repositoryLabel: UILabel!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var titleTextField: UITextField! {
    didSet {
      self.titleTextField.delegate = self
    }
  }
  
  @IBOutlet weak var bodyLabel: UILabel!
  @IBOutlet weak var bodyTextField: UITextField! {
    didSet {
      self.bodyTextField.delegate = self
    }
  }
  
  @IBOutlet weak var addLabelsLabel: UILabel!
  @IBOutlet weak var addAssigneeLabel: UILabel!
  @IBOutlet weak var addMilestoneLabel: UILabel!
  
  private var repository: Repository?
  private var fetchedRepositories: [Repository] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Request.delegate = self
    
    Request.requestUserRepositories()
    
    self.setupLocalization()
  }
}

// MARK: - Setup
extension AddIssueTableViewController: Setup {
  
  func setupLocalization() {
    self.title = "__ADD_AN_ISSUE__".localized
    
    self.repositoryLabel.text = "__CHOOSE_A_REPOSITORY__".localized
    
    self.titleLabel.text = "__TITLE__".localized
    self.titleTextField.placeholder = "__TITLE_PLACEHOLDER__".localized
    
    self.bodyLabel.text = "__BODY__".localized
    self.bodyTextField.placeholder = "__BODY_PLACEHOLDER__".localized
    
    self.addLabelsLabel.text = "__ADD_LABELS__".localized
    self.addAssigneeLabel.text = "__ADD_ASSIGNEE__".localized
    self.addMilestoneLabel.text = "__ADD_MILESTONE__".localized
  }
}

// MARK: - RequestDelegate
extension AddIssueTableViewController: RequestDelegate {
  
  func refresh(repositories: [Repository]) {
    if self.fetchedRepositories.isEmpty {
      self.fetchedRepositories += repositories
      self.titleTextField.becomeFirstResponder()
    }
  }
  
  func refresh(repository: Repository) {
    let x = "x"
    
    print(repository)
  }
}

// MARK: - RepositoryDelegate
extension AddIssueTableViewController: RepositoryDelegate {
  
  func repositoryChosen(repository: Repository) {
    func enableSaveButtonIfNeeded() {
      guard self.titleTextField.text?.characters.count > 0 else { return }
      
      self.saveButton.enabled = true
    }
    
    func enableOrDisableExtraOptions() {
      func enableExtraOptions() {
        self.addLabelsLabel.enabled = true
        self.addAssigneeLabel.enabled = true
        self.addMilestoneLabel.enabled = true
      }
      
      func disableExtraOptions() {
        self.addLabelsLabel.enabled = false
        self.addAssigneeLabel.enabled = false
        self.addMilestoneLabel.enabled = false
      }
      
      if let canPush = self.repository?.canPush {
        canPush ? enableExtraOptions() : disableExtraOptions()
      }
    }
    
    self.repository = repository
    
    self.repositoryLabel.text = self.repository?.fullName
    
    if let avatarURL = self.repository?.owner.avatarURL {
      self.repositoryImageView.hnk_setImageFromURL(avatarURL)
    }
    
    enableSaveButtonIfNeeded()
    enableOrDisableExtraOptions()
    
    self.tableView.beginUpdates()
    self.tableView.reloadRowsAtIndexPaths([TopIndexPath], withRowAnimation: .None)
    self.tableView.endUpdates()
  }
  
  func repositoriesFetched(repositories: [Repository]) {
    self.fetchedRepositories = repositories
  }
}

// MARK: - UITableView delegate
extension AddIssueTableViewController {
  
  // Setup automatic cell resizing. Seems you need to do so per indexPath in a static tableview.
  override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 44
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    guard indexPath.section == 0 else { return indexPath }
    
    switch(indexPath.row) {
    case SelectTitle:
      self.titleTextField.becomeFirstResponder()
    case SelectBody:
      self.bodyTextField.becomeFirstResponder()
    default:
      return indexPath
    }
    
    return indexPath
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    guard section == 1 else { return nil }
    
    return "__LABEL_ASSIGNEE_MILESTONE_DISCLAIMER__".localized
  }
}

// MARK: - UITextFieldDelegate
extension AddIssueTableViewController: UITextFieldDelegate {
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    guard textField != self.bodyTextField else { return true }
    
    var isTitleTextField: Bool {
      return textField == self.titleTextField
    }
    
    var titleIsEmpty: Bool {
      let minusOne = isTitleTextField && string.isEmpty
      let plusOne = isTitleTextField && !string.isEmpty
      
      let chars: Int
      
      if minusOne {
        chars = (self.titleTextField.text?.characters.count ?? 0) - 1
        
        return chars <= 0
      } else if plusOne {
        chars = (self.titleTextField.text?.characters.count ?? 0) + 1
        
        return chars <= 0
      }
      
      return true
    }
    
    var repositoryIsSelected: Bool {
      if let _ = self.repository {
        return true
      }
      
      return false
    }
    
    if !titleIsEmpty && repositoryIsSelected {
      self.saveButton.enabled = true
    } else {
      self.saveButton.enabled = false
    }
    
    return true
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    guard textField == self.bodyTextField else { self.bodyTextField.becomeFirstResponder(); return true }
    
    if self.saveButton.enabled {
      self.createIssue(textField)
    }
    
    return true
  }
}

// MARK: - Actions
extension AddIssueTableViewController {
  
  @IBAction func cancelAddIssue(sender: AnyObject) {
    self.resignFirstResponders()
    
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func createIssue(sender: AnyObject) {
    if let repository = self.repository,
       let title = self.titleTextField.text,
       let body = self.bodyTextField.text {
      let parameters: Parameters = ["title": title, "body": body]
      
      Request.createIssue(parameters, repository: repository)
        
      self.resignFirstResponders()
        
      self.dismissViewControllerAnimated(true, completion: nil)
    }
  }
}

// MARK: - Navigation
extension AddIssueTableViewController {
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    switch identifier {
    case AddLabel, AddAssignee, AddMilestone:
      guard let repository = self.repository where repository.canPush else { return false }
    default:
      return true
    }
    
    return true
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let identifier = segue.identifier else { return }
    
    switch identifier {
    case AddRepository:
      if let dvc = segue.destinationViewController as? RepositoryTableViewController {
        dvc.delegate = self
        
        dvc.repositories = self.fetchedRepositories
      }
    case AddLabel:
      if let dvc = segue.destinationViewController as? LabelTableViewController,
       let repository = self.repository {
        dvc.repository = repository
      }
    case AddAssignee:
      if let dvc = segue.destinationViewController as? AssigneeTableViewController,
        let repository = self.repository {
          dvc.repository = repository
      }
    case AddMilestone:
      if let dvc = segue.destinationViewController as? MilestoneTableViewController,
        let repository = self.repository {
          dvc.repository = repository
      }
    default:
      print("Invalid segue")
    }
  }
}

// MARK: - Private
private extension AddIssueTableViewController {
  
  func resignFirstResponders() {
    self.titleTextField.resignFirstResponder()
    self.bodyTextField.resignFirstResponder()
  }
}