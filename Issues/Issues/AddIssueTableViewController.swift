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

class AddIssueTableViewController: UITableViewController {
  
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var titleTextField: UITextField!
  
  @IBOutlet weak var bodyLabel: UILabel!
  @IBOutlet weak var bodyTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.titleTextField.delegate = self
    self.titleTextField.becomeFirstResponder()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - UITableView delegate
extension AddIssueTableViewController {
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

// MARK: - UITextFieldDelegate
extension AddIssueTableViewController: UITextFieldDelegate {
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    var isEmpty: Bool {
      return string.isEmpty && textField.text?.characters.count <= 1
    }
    
    if isEmpty {
      self.saveButton.enabled = false
    } else {
      self.saveButton.enabled = true
    }
    
    return true
  }
}

// MARK: - Actions
extension AddIssueTableViewController {
  
  @IBAction func cancelAddIssue(sender: AnyObject) {
    self.titleTextField.resignFirstResponder()
    self.bodyTextField.resignFirstResponder()
    
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}

// MARK: - Navigation
extension AddIssueTableViewController {
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
}