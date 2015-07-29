//
//  String+Localization.swift
//  Issues
//
//  Created by Bas Broek on 29/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension String {
  
  /// Returns the localized version of the provided string.
  public var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
  }
}