//
//  Lockable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Lockable {
  
  func lock()
  func unlock()
}

extension Issue where Self: Lockable {
  
  public var locked: Bool {
    return true
  }
}