//
//  RefreshDelegate.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

public protocol RefreshDelegate {
  
  func endRefreshing()
}

extension RefreshDelegate where Self: UITableViewController {
  
  /// Tells the control that a refresh operation has ended.
  public func endRefreshing() {
    self.refreshControl?.endRefreshing()
  }
}