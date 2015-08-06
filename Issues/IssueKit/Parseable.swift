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
  
  func parseLabels(json: [JSON]) -> Set<Label>
  func parseMilestone(json: [String: JSON]) throws -> Milestone
  
  func parseUser(json: [String: JSON]) -> User?
}