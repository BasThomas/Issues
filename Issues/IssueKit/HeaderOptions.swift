//
//  HeaderOptions.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public typealias ETag = String
public typealias Headers = [String: String]

/// Authorization key-value pair.
private let Authorization = "token \(Value.OAuth.AccessToken)"

public struct HeaderOptions {
  
  let authorization: String
  let eTag: ETag
  
  public init(eTag: ETag? = "") {
    self.authorization = Authorization
    self.eTag = eTag ?? ""
  }
}

// MARK: - Hashable
extension HeaderOptions: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return self.eTag.hashValue
  }
}

// MARK: - Equatable
extension HeaderOptions: Equatable {}

public func ==(lhs: HeaderOptions, rhs: HeaderOptions) -> Bool {
  return lhs.eTag == rhs.eTag
}