//
//  ParseController.swift
//  Issues
//
//  Created by Bas Broek on 11/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ParseController {
  
  /// Returns the shared ParseController.
  public static let sharedInstance = ParseController()
  
  /// The delegate of the ParseController.
  var delegate: ParseDelegate?
}

// MARK: - Parseable
extension ParseController: Parseable {
  
  /// Parses all issues across all the authenticated user’s visible repositories
  /// including owned repositories, member repositories, and organization repositories
  ///
  /// - Parameter json: json to parse.
  ///
  /// - Returns: `[Issue]` array of issues, empty if none are found.
  func parseIssues(json: JSON) -> [Issue] {
    var issues: [Issue] = []
    
    for issue in json {
      let issue = issue.1
      
      if let title = issue["title"].string,
         let number = issue["number"].int, let creationDate = issue["created_at"].string?.date {
        
        let ghIssue = GitHubIssue(number: number, title: title, creationDate: creationDate)
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
  func optionalJSONFromAnyObject(anyObject data: AnyObject?) -> JSON? {
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
  func jsonFromAnyObject(anyObject data: AnyObject?) throws -> JSON {
    guard let data = data else { throw JSONError.InvalidObject }
    
    return JSON(data)
  }
}