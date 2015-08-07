//
//  LowercaseInitializable.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol LowercaseInitializable: RawRepresentable {
  
  static var allValues: [Self] { get }
  
  init?(rawValue: RawValue)
}

extension LowercaseInitializable {
  
  public init?(rawValue: RawValue) {
    let rv = "\(rawValue)"
    
    let value = Self.allValues.filter { ($0.rawValue as? String)?.lowercaseString == rv.lowercaseString }
    
    guard let state = value.first else { return nil }
    
    self = state
  }
}