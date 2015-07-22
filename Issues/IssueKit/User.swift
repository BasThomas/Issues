//
//  User.swift
//  Issues
//
//  Created by Bas on 06/07/2015.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public typealias Assignee = User

public struct User {
  
  public var name: String
  
  public init(name: String) {
    self.name = name
  }
}

extension User: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return name.hashValue
  }
}

extension User: Equatable {}

public func ==(lhs: User, rhs: User) -> Bool {
  return lhs.name == rhs.name
}