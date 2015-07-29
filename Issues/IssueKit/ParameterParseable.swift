//
//  ParameterParseable.swift
//  Issues
//
//  Created by Bas Broek on 26/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public typealias Parameters = [String: AnyObject]

protocol ParameterOptions { }

protocol ParameterParseable {
  
  func parseParameterOptions(parameterOptions: ParameterOptions) -> Parameters
}

extension ParameterParseable {
  
  /// Parses ParameterOptions to Parameters.
  /// Only non-empty key-value pairs are added.
  ///
  /// - Parameter parameterOptions: parameterOptions to evaluate.
  ///
  /// - Returns `Parameters`
  func parseParameterOptions(parameterOptions: ParameterOptions) -> Parameters {
    var parameters: Parameters = [:]
    
    typealias Child = (key: String?, value: protocol<>)
    
    func add(child: Child) -> Bool {
      guard let key = child.key else { return false }
      guard let value = child.value as? AnyObject else { return false }
      guard value as? String != "" else { return false }
      
      parameters[key] = value
      
      return true
    }
    
    let mirror = Mirror(reflecting: parameterOptions)
    mirror.children.map { $0 }.map { add($0) }
    
    return parameters
  }
}