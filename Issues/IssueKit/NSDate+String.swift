//
//  NSDate+String.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension NSDate {
  
  public var stringValue: String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "YYYY-MM-DDTHH:MM:SSZ"
    
    return formatter.stringFromDate(self)
  }
}