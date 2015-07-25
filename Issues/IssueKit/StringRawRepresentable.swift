//
//  StringRawRepresentable.swift
//  Issues
//
//  Created by Bas Broek on 24/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol StringRawRepresentable {
  
  var string: String? { get }
  var stringValue: String { get }
}

extension StringRawRepresentable where Self: RawRepresentable {
  
  /// Enum case's string; nil if unknown.
  public var string: String? {
    return (self.rawValue as? String)?.lowercaseString
  }
  
  /// Enum case's stringValue; "" if unknown.
  public var stringValue: String {
    return self.string ?? ""
  }
}