//
//  IntRawRepresentable.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol IntRawRepresentable {
  
  var int: Int? { get }
  var intValue: Int { get }
}

extension IntRawRepresentable where Self: RawRepresentable {
  
  /// Enum case's int; nil if unknown.
  public var int: Int? {
    return self.rawValue as? Int
  }
  
  /// Enum case's intValue; -1 if unknown.
  public var intValue: Int {
    return self.int ?? -1
  }
}