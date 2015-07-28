//
//  GitHubRepository.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct GitHubRepository: Repository {
  
  /// Name of the repository.
  public var name: String
  
  /// Issues of the repository.
  public var issues: [Issue]
  
  /// Labels of the repository.
  public var labels: [Label]
  
  /// Milestones of the repository
  public var milestones: [Milestone]
  
  public init(name: String, issues: [Issue] = [], labels: [Label] = [], milestones: [Milestone] = []) {
    self.name = name
    self.issues = issues
    self.labels = labels
    self.milestones = milestones
  }
  
  /// Adds an issue to the repository.
  ///
  /// - Parameter issue: issue to add to the repository.
  public mutating func addIssue(issue: Issue) {
    self.issues.append(issue)
  }
  
  /// Opens a new issue with a title and, if wanted, a body.
  ///
  /// - Parameter title: title of the issue.
  /// - Parameter body: body of the issue. Defaults to `nil`.
  ///
  /// - Throws: `CreationError` if the issue couldn't be created.
  ///
  /// - Returns `Issue` the created Issue.
  public func addIssue(withTitle title: String, body: String? = nil) throws -> Issue {
//    POST /repos/:owner/:repo/issues

//    {
//      "title": "Found a bug",
//      "body": "I'm having a problem with this.",
//      "assignee": "octocat",
//      "milestone": 1,
//      "labels": [
//      "Label1",
//      "Label2"
//      ]
//    }
    _ = ImmatureGitHubIssue(title: title, body: body)
    
    throw CreationError.Unknown
  }
  
  /// Gets an array of issues with the specific labels.
  ///
  /// - Parameter labels: labels to search for.
  ///
  /// - Returns `[Issue]` the found issues.
  public func issuesWithLabels(labels: [Label]) -> [Issue] {
    return []
  }
  
  /// Gets an array of issues with the specific milestone.
  ///
  /// - Parameter milestone: milestone to search for.
  ///
  /// - Returns `[Issue]` the found issues.
  public func issuesWithMilestone(milestone: Milestone) -> [Issue] {
    return []
  }
}

// MARK: - ImmatureGitHubIssue
extension GitHubRepository {
  
  private struct ImmatureGitHubIssue {
    
    var title: String
    var body: String?
    var assignee: String?
    var milestone: Int?
    var labels: [String]?
    
    init(title: String, body: String? = nil, assignee: Assignee? = nil, milestone: Milestone? = nil, labels: [Label]? = nil) {
      self.title = title
      self.body = body
      self.assignee = assignee?.name
      self.milestone = milestone?.id
      
      if let stringLabels = labels {
        self.labels = stringLabels.map { $0.name }
      }
    }
  }
}


// MARK: - Labelable
extension GitHubRepository: Labelable {
  
  /// Adds a label to the repository.
  ///
  /// - Parameter label: label to add.
  public mutating func addLabel(label: Label) {
    self.labels.append(label)
//    POST /repos/:owner/:repo/labels
  }
  
  public func editLabel(label: Label, withLabel editedLabel: Label) {
//    PATCH /repos/:owner/:repo/labels/:name
  }
  
  /// Removes the label from the repository.
  ///
  /// - Parameter label: label to remove.
  public mutating func removeLabel(label: Label) {
    self.labels.removeObject(label)
//    DELETE /repos/:owner/:repo/labels/:name
  }
}

// MARK: - Milestoneable
extension GitHubRepository: Milestoneable {
  
  /// Adds a milestone to the repository.
  ///
  /// - Parameter milestone: milestone to add.
  public mutating func addMilestone(milestone: Milestone) {
    self.milestones.append(milestone)
//    POST /repos/:owner/:repo/milestones
    
//    {
//      "title": "v1.0",
//      "state": "open",
//      "description": "Tracking milestone for version 1.0",
//      "due_on": "2012-10-09T23:39:01Z"
//    }
  }
  
  public func editMilestone(milestone: Milestone, withMilestone editedMilestone: Milestone) {
//    PATCH /repos/:owner/:repo/milestones/:number
  }
  
  /// Removes a milestone from the repository.
  ///
  /// - Parameter milestone: milestone to remove.
  public mutating func removeMilestone(milestone: Milestone) {
//    DELETE /repos/:owner/:repo/milestones/:number
  }
}

// MARK: - Hashable
extension GitHubRepository: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return self.name.hashValue
  }
}

// MARK: - Equatable
extension GitHubRepository: Equatable { }

public func ==(lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
  return lhs.name == rhs.name &&
    lhs.labels == rhs.labels
}