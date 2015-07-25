//
//  State.swift
//  Issues
//
//  Created by Bas on 06/07/2015.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public enum State: String, LowercaseInitializable {
  
  case Open
  case Closed
  
  /// All values of the enum.
  public static let allValues = [Open, Closed]
}

extension State {
  
  public init?(rawValue: String) {
    let value = State.allValues.filter { $0.rawValue.lowercaseString == rawValue.lowercaseString }
    
    if let state = value.first {
      self = state
    } else {
      return nil
    }
  }
}