//
//  String+NSDate.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension String {
  
  /// A String's date.
  public var date: NSDate? {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ" // http://stackoverflow.com/questions/28791771/swift-iso-8601-date-formatting-with-ios7
    
    return formatter.dateFromString(self)
  }
}