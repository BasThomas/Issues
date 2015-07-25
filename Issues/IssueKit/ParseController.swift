//
//  ParseController.swift
//  Issues
//
//  Created by Bas Broek on 11/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol ParseDelegate {
  
}

public class ParseController {
  
  public static let sharedInstance = ParseController()
  
//  public func parseIssues(jsonString: String) -> [Issue] {
//    if let json = self.parseJSON(jsonString) {
//      if let json = json as? NSArray {
//        let jsonDict = json[0]
//        
//        if let number = jsonDict["number"] as? Int,
//          let title = jsonDict["title"] as? String,
//          let body = jsonDict["body"] as? String,
//          let state = jsonDict["state"] as? String {
//          
//          let enumState = State(rawValue: state)
//          print("num: \(number), title: \(title), body: \(body). state: \(enumState)")
//        }
//        
//      } else if let json = json as? NSDictionary {
//        print("it's a dict: \(json)")
//      }
//    }
//    
//    return []
//  }
}

// MARK: - Parseable
extension ParseController: Parseable {
  
  /// Parses all issues across all the authenticated user’s visible repositories including owned repositories, member repositories, and organization repositories
  ///
  /// - Parameter json: json to parse.
  ///
  /// - Returns: `[Issue]` array of issues, empty if none are found.
  public func parseIssues(json: JSON) -> [Issue] {
    print("JSON: \(json)")
    return []
  }
  
  /// Parses all issues across owned and member repositories for the authenticated user
  ///
  /// - Parameter json: json to parse.
  ///
  /// - Returns: `[Issue]` array of issues, empty if none are found.
  public func parseUserIssues(json: JSON) -> [Issue] {
    print("JSON: \(json)")
    return []
  }
  
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

extension ParseController {
  
  /// Parses AnyObject? to JSON?
  ///
  /// - Parameter anyObject: data to parse.
  ///
  /// - Returns `JSON?`
  public func optionalJSONFromAnyObject(anyObject data: AnyObject?) -> JSON? {
    guard let data = data else { return nil }
    
    return JSON(data)
  }
  
  /// Parses AnyObject? to JSON.
  ///
  /// - Parameter anyObject: data to parse.
  ///
  /// - Throws: `InvalidObject` when failing to parse the data.
  ///
  /// - Returns `JSON`
  public func jsonFromAnyObject(anyObject data: AnyObject?) throws -> JSON {
    guard let data = data else { throw JSONError.InvalidObject }
    
    return JSON(data)
  }
}