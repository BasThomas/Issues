//
//  HeaderParseable.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

protocol HeaderParseable {
  
  func parseHeaders(headerOptions: HeaderOptions) -> Headers
}

/// If-Non-Match header.
private let IfNoneMatch = "If-None-Match"

extension HeaderParseable {
  
  /// Parses HeaderOptions to Headers.
  /// Only non-empty key-value pairs are added.
  ///
  /// - Parameter headerOptions: headerOptions to evaluate.
  ///
  /// - Returns `Headers`
  func parseHeaders(headerOptions: HeaderOptions = HeaderOptions()) -> Headers {
    var headers: Headers = [:]
    
    typealias Child = (label: Optional<String>, value: protocol<>)
    
    func add(child: Child) -> Bool {
      guard let _key = child.label else { return false }
      guard let value = child.value as? String else { return false }
      guard value != "" else { return false }
      
      let key: String
      
      if _key.lowercaseString == "etag" {
        key = IfNoneMatch
      } else {
        key = _key
      }
      
      headers[key] = value
      
      return true
    }
    
    let mirror = Mirror(reflecting: headerOptions)
    mirror.children.map { $0 }.map { header in add(header) }
    
    return headers
  }
}