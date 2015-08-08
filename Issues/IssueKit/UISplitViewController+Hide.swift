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
    guard !self.collapsed else { self.dismissSearchController(searchController); return }
    guard UIDevice.currentDevice().userInterfaceIdiom == .Pad else { return }
    
    let barButtonItem = self.displayModeButtonItem()
    UIApplication.sharedApplication().sendAction(barButtonItem.action, to: barButtonItem.target, from: nil, forEvent: nil)
  }
  
  public func dismissSearchController(searchController: UISearchController?) {
    if let searchController = searchController where searchController.active {
      searchController.active = false
    }
  }
  
  public func masterViewController(afterNavigationController after: Bool = true) -> UIViewController? {
    if !after {
      return self.viewControllers.first
    }
    
    return (self.viewControllers.first as? UINavigationController)?.viewControllers.first
  }
}