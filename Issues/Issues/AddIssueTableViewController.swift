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

private let SelectTitle = 1
private let SelectBody = 2

class AddIssueTableViewController: UITableViewController {
  
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  @IBOutlet weak var repositoryLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var titleTextField: UITextField!
  
  @IBOutlet weak var bodyLabel: UILabel!
  @IBOutlet weak var bodyTextField: UITextField!
  
  private var repository: Repository?
  private var fetchedRepositories: [Repository] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Request.delegate = self
    
    Request.requestUserRepositories()
    
    self.setupLocalization()
    
    self.titleTextField.delegate = self
    self.bodyTextField.delegate = self
    
    self.titleTextField.becomeFirstResponder()
  }
}

// MARK: - Setup
extension AddIssueTableViewController: Setup {
  
  func setupLocalization() {
    self.title = NSLocalizedString("__ADD_AN_ISSUE__", comment: "Add an issue")
    
    self.repositoryLabel.text = NSLocalizedString("__CHOOSE_A_REPOSITORY__", comment: "Choose a repository")
    
    self.titleLabel.text = NSLocalizedString("__TITLE__", comment: "Title")
    self.titleTextField.placeholder = NSLocalizedString("__TITLE_PLACEHOLDER__", comment: "Title placeholder")
    
    self.bodyLabel.text = NSLocalizedString("__BODY__", comment: "Body")
    self.bodyTextField.placeholder = NSLocalizedString("__BODY_PLACEHOLDER__", comment: "Body placeholder")
  }
}

// MARK: - RequestDelegate
// MARK: - RequestDelegate
extension AddIssueTableViewController: RequestDelegate {
  
  func refresh(issues: [Issue]) { }
  
  func refresh(repositories: [Repository]) {
    if self.fetchedRepositories.isEmpty {
      self.fetchedRepositories += repositories
    }
  }
}

// MARK: - RepositoryDelegate
extension AddIssueTableViewController: RepositoryDelegate {
  
  func repositoryChosen(repository: Repository) {
    func enableSaveButtonIfNeeded() {
      guard self.titleTextField.text?.characters.count > 0 else { return }
      
      self.saveButton.enabled = true
    }
    
    self.repository = repository
    
    self.repositoryLabel.text = self.repository?.fullName
    
    enableSaveButtonIfNeeded()
  }
  
  func repositoriesFetched(repositories: [Repository]) {
    self.fetchedRepositories = repositories
  }
}

// MARK: - UITableView delegate
extension AddIssueTableViewController {
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
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
    self.cancelAddIssue(textField)
    
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let dvc = segue.destinationViewController as? RepositoryTableViewController
    
    if let dvc = dvc {
      dvc.delegate = self
      
      dvc.repositories = self.fetchedRepositories
    }
  }
}

// MARK: - Private
extension AddIssueTableViewController {
  
  private func resignFirstResponders() {
    self.titleTextField.resignFirstResponder()
    self.bodyTextField.resignFirstResponder()
  }
}