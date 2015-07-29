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

/// The v3 version Accept header.
private let Accept = "application/vnd.github.v3+json"

/// The request's content type.
private let ContentType = "application/json"

public struct HeaderOptions {
  
  let authorization: String
  let accept: String
  let contentType: String
  let eTag: ETag
  
  public init(eTag: ETag? = "") {
    self.authorization = Authorization
    self.accept = Accept
    self.contentType = ContentType
    
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