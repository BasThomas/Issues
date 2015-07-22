//
//  Array+Remove.swift
//  Issues
//
//  Created by Bas Broek on 23/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
  
  /// Removes the object from the array.
  ///
  /// - Parameter object: object to remove.
  ///
  /// - Returns `Bool` true if the object could be removed, else false.
  mutating func removeObject(object: Generator.Element) -> Bool {
    if let index = self.indexOf(object) {
      self.removeAtIndex(index)
      
      return true
    }
    
    return false
  }
}