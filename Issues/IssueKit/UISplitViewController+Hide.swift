//
//  UISplitViewController+Hide.swift
//  Issues
//
//  Created by Bas Broek on 02/08/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension UISplitViewController {
  
  public func toggleMasterView(searchController: UISearchController? = nil) {
    guard UIDevice.currentDevice().userInterfaceIdiom == .Pad else { self.dismissSearchController(searchController); return }
    
    let barButtonItem = self.displayModeButtonItem()
    UIApplication.sharedApplication().sendAction(barButtonItem.action, to: barButtonItem.target, from: nil, forEvent: nil)
  }
}

private extension UISplitViewController {
  
  func dismissSearchController(searchController: UISearchController?) {
    if let searchController = searchController where searchController.active {
      searchController.active = false
    }
  }
}