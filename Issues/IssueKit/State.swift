//
//  State.swift
//  Issues
//
//  Created by Bas on 06/07/2015.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public enum State: String {
  case Open
  case Closed
  
  public static let allValues = [Open, Closed]
  
  public init?(rawValue: String) {
    for value in State.allValues {
      if value.rawValue.lowercaseString == rawValue.lowercaseString {
        self = value
        
        return
      }
    }
    
    return nil
  }
}