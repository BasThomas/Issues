//
//  Label.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public typealias Hex = String

public struct Label {
  
  public var name: String
  public var color: Hex
}

extension Label: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return name.hashValue ^ color.hashValue
  }
}

extension Label: Equatable {}

public func ==(lhs: Label, rhs: Label) -> Bool {
  return lhs.name == rhs.name && lhs.color == rhs.color
}