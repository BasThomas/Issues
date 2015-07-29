//
//  Setup.swift
//  Issues
//
//  Created by Bas Broek on 29/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

public protocol Setup {
  
  func setupLocalization()
  func setupAutomaticCellResizing()
  func setupSearch()
}

extension Setup where Self: UITableViewController {
  
  public func setupAutomaticCellResizing() {
    self.tableView.estimatedRowHeight = 44
    self.tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  public func setupSearch() { }
}