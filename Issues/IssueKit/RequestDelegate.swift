//
//  RequestDelegate.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import SwiftyJSON

public protocol RequestDelegate {
  
  func refresh(issue: Issue)
  func refresh(issues: [Issue])
  func refresh(issue: Issue, labels: Set<Label>)
  func refresh(repositories: [Repository])
  func endRefreshing()
}

extension RequestDelegate {
  
  public func refresh(issue: Issue) { }
  public func refresh(issues: [Issue]) { }
  public func refresh(issue: Issue, labels: Set<Label>) { }
  public func refresh(repositories: [Repository]) { }
  public func endRefreshing() { }
}

extension RequestDelegate where Self: UITableViewController {
  
  /// Tells the control that a refresh operation has ended.
  public func endRefreshing() {
    self.refreshControl?.endRefreshing()
  }
}