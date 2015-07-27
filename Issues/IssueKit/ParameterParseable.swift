//
//  ParameterParseable.swift
//  Issues
//
//  Created by Bas Broek on 26/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public typealias Parameters = [String: AnyObject]

protocol ParameterParseable {
  
  func parseIssueParameterOptions(parameterOptions: IssueParameterOptions) -> Parameters
}

extension ParameterParseable {
  
  /// Parses IssueParameterOptions to Parameters.
  /// Only non-empty key-value pairs are added.
  ///
  /// - Parameter parameterOptions: parameterOptions to evaluate.
  ///
  /// - Returns `Parameters`
  func parseIssueParameterOptions(parameterOptions: IssueParameterOptions = IssueParameterOptions()) -> Parameters {
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
    mirror.children.map { $0 }.map { parameter in add(parameter) }
    
    return parameters
  }
}