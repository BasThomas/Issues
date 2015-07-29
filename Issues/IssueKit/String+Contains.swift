//
//  String+Contains.swift
//  Issues
//
//  Created by Bas Broek on 29/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension String {
  
  public func contains(string: String) -> Bool {
    return self.lowercaseString.rangeOfString(string.lowercaseString) != nil
  }
}