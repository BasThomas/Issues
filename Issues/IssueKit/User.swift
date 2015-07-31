//
//  User.swift
//  Issues
//
//  Created by Bas on 06/07/2015.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct User {
  
  public var id: Int
  
  public var avatarURL: String
  
  /// Name of the user.
  public var name: String
  
  public init(id: Int, avatarURL: String, name: String) {
    self.id = id
    self.avatarURL = avatarURL
    self.name = name
  }
}

// MARK: - Hashable
extension User: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return name.hashValue
  }
}

// MARK: - Equatable
extension User: Equatable {}

public func ==(lhs: User, rhs: User) -> Bool {
  return lhs.name == rhs.name
}