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
  public var hex: Hex
  
  public init(name: String, hex: Hex) {
    self.name = name
    self.hex = hex
  }
}

// MARK: - CustomStringConvertible
extension Label: CustomStringConvertible, Printable {
  
  /// A textual representation of `self`.
  public var description: String {
    return "\(self.file): name = \(self.name), color = \(self.hex)"
  }
}

// MARK: - Hashable
extension Label: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return name.hashValue ^ hex.hashValue
  }
}

// MARK: - Equatable
extension Label: Equatable {}

public func ==(lhs: Label, rhs: Label) -> Bool {
  return lhs.name == rhs.name &&
    lhs.hex == rhs.hex
}