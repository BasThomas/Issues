//
//  Label.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct Label {
  
  /// Name of the label.
  public var name: String
  
  /// Hex(color) of the label.
  public var color: Hex
  
  public init(name: String, color: Hex) {
    self.name = name
    self.color = color
  }
}

// MARK: - CustomStringConvertible
extension Label: CustomStringConvertible, Printable {
  
  /// A textual representation of `self`.
  public var description: String {
    return "\(self.file): name = \(self.name), color = \(self.color)"
  }
}

// MARK: - Hashable
extension Label: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return name.hashValue ^ color.hashValue
  }
}

// MARK: - Equatable
extension Label: Equatable {}

public func ==(lhs: Label, rhs: Label) -> Bool {
  return lhs.name == rhs.name &&
    lhs.color == rhs.color
}