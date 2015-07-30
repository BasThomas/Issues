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
// MARK: - Issues
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
      
      // Skips any pull requests.
      guard issue["pull_request"].dictionary == nil else { continue }
      
      if let number = issue["number"].int,
         let title = issue["title"].string,
         let body = issue["body"].string,
         let _state = issue["state"].string,
         let state = State(rawValue: _state),
         let locked = issue["locked"].bool,
         let creationDate = issue["created_at"].string?.date {
          
        let milestone = issue["milestone", "number"].int
//        print("milestone: \(milestone)")
        
        let closingDate = issue["closed_at"].string?.date
        
        let ghIssue = GitHubIssue(number: number, title: title, body: body, state: state, locked: locked, creationDate: creationDate, closingDate: closingDate)
        issues.append(ghIssue)
      }
    }
    
    self.delegate?.parsedIssues(issues)
    return issues
  }
}

// MARK: Repositories
extension ParseController {
  
  /// Parses all repositories of every public repository, in the order that they were created.
  ///
  /// - Parameter json: json to parse.
  ///
  /// - Returns: `[Repository]` array of repositories, empty if none are found.
  func parseRepositories(json: JSON) -> [Repository] {
    var repositories: [Repository] = []
    
    for repository in json {
      let repository = repository.1
      
      if let owner = repository["owner", "login"].string,
         let name = repository["name"].string,
         let fullName = repository["full_name"].string {
        let commentsURL = repository["comments_url"].string
        print("commentsURL: \(commentsURL)")
        let assigneesURL = repository["assignees_url"].string
        print("assigneesURL: \(assigneesURL)")
        let labelsURL = repository["labels_url"].string
        print("labelsURL: \(labelsURL)")
        let milestonesURL = repository["milestones_url"].string
        print("milestonesURL: \(milestonesURL)")
        
        let ghRepository = GitHubRepository(owner: owner, name: name, fullName: fullName)
        repositories.append(ghRepository)
      }
    }
    
    self.delegate?.parsedRepositores(repositories)
    return repositories
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