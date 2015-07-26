//
//  ParameterParseable.swift
//  Issues
//
//  Created by Bas Broek on 26/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public typealias Parameters = [String: AnyObject]

public protocol ParameterParseable {
  
  func parseIssueParameterOptions(parameterOptions: IssueParameterOptions) -> Parameters
}

extension ParameterParseable {
  
  /// Parses IssueParameterOptions to Parameters.
  /// Only non-empty key-value pairs are added.
  ///
  /// - Parameter parameterOptions: parameterOptions to evaluate.
  ///
  /// - Returns `Parameters`
  public func parseIssueParameterOptions(parameterOptions: IssueParameterOptions) -> Parameters {
    var parameters: Parameters = [:]
    
    typealias Child = (label: Optional<String>, value: protocol<>)
    
    func addToDictionary(child: Child) -> Bool {
      guard let key = child.label else { return false }
      guard let value = child.value as? AnyObject else { return false }
      guard value as? String != "" else { return false }
      
      parameters[key] = value as? String
      
      return true
    }
    
    let mirror = Mirror(reflecting: parameterOptions)
    mirror.children.map { $0 }.map { parameter in addToDictionary(parameter) }
    
    return parameters
  }
}