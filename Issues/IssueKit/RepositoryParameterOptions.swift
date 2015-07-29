//
//  RepositoryParameterOptions.swift
//  Issues
//
//  Created by Bas Broek on 29/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct RepositoryParameterOptions: ParameterOptions {
  
  let visibility: String
  let affiliation: String
  let type: String
  let sort: String
  let direction: String
  
  public init(visibility: String = "", affiliation: String = "", type: String = "", sort: String = Value.Sort.Pushed, direction: String = "") {
    self.visibility = visibility
    self.affiliation = affiliation
    self.type = type
    self.sort = sort
    self.direction = direction
  }
}

// MARK: - Hashable
extension RepositoryParameterOptions: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return self.visibility.hashValue ^ self.affiliation.hashValue ^ self.type.hashValue ^ self.sort.hashValue ^ self.direction.hashValue
  }
}

// MARK: - Equatable
extension RepositoryParameterOptions: Equatable {}

public func ==(lhs: RepositoryParameterOptions, rhs: RepositoryParameterOptions) -> Bool {
  return lhs.visibility == rhs.visibility &&
    lhs.affiliation == rhs.affiliation &&
    lhs.type == rhs.type &&
    lhs.sort == rhs.sort &&
    lhs.direction == rhs.direction
}