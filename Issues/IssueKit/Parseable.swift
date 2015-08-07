//
//  Parseable.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Parseable: ParameterParseable, HeaderParseable {
  
  func parseIssues(json: JSON) -> [Issue]
  
  func parseRepositories(json: JSON) -> [Repository]
  
  func getRepositoryForIssue(issue: Issue, json: [String: JSON]) throws
  func parseRepositoryForIssue(issue: Issue, json: JSON)
  
  func parseLabels(json: [JSON]) -> [Label]
  func parseUser(json: [String: JSON]) -> User?
  func parseMilestone(json: [String: JSON]) throws -> Milestone
  
  func parseLabels(json: JSON, forRepository repository: Repository?) -> [Label]
  func parseAssignees(json: JSON, forRepository repository: Repository?) -> [Assignee]
  func parseMilestones(json: JSON, forRepository repository: Repository?) -> [Milestone]
}