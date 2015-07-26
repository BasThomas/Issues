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
  
  func parsedIssues(issues: [Issue])
}

public class ParseController {
  
  /// Returns the shared ParseController.
  public static let sharedInstance = ParseController()
  
  /// The delegate of the ParseController.
  public var delegate: ParseDelegate?
}

// MARK: - Parseable
extension ParseController: Parseable {
  
  /// Parses all issues across all the authenticated user’s visible repositories
  /// including owned repositories, member repositories, and organization repositories
  ///
  /// - Parameter json: json to parse.
  ///
  /// - Returns: `[Issue]` array of issues, empty if none are found.
  public func parseIssues(json: JSON) -> [Issue] {
    var issues: [Issue] = []
    
    for issue in json {
      let issue = issue.1
      
      if let title = issue["title"].string,
         let number = issue["number"].int {
        
        let ghIssue = GitHubIssue(number: number, title: title)
        issues.append(ghIssue)
      }
    }
    
    self.delegate?.parsedIssues(issues)
    return issues
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