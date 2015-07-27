//
//  LowercaseInitializable.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol LowercaseInitializable {
  
  static var allValues: [Self] { get }
  
  init?(rawValue: String)
}

extension LowercaseInitializable where Self: RawRepresentable {
  
  public init?<T: Equatable>(rawValue: T) {
    let value = Self.allValues.filter { ($0.rawValue as? String)?.lowercaseString == (rawValue as? String)?.lowercaseString }
    
    guard let state = value.first else { return nil }
    
    self = state
  }
}