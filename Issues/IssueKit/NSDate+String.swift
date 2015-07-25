//
//  NSDate+String.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension NSDate {
  
  /// NSDate's stringValue.
  public var stringValue: String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ" // http://stackoverflow.com/questions/28791771/swift-iso-8601-date-formatting-with-ios7
    
    return formatter.stringFromDate(self)
  }
}