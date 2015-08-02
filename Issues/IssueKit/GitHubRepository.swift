//
//  GitHubRepository.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct GitHubRepository: Repository {
  
  /// Unique id.
  public var id: Int
  
  /// Owner of the repository
  public var owner: User
  
  /// Name of the repository.
  public var name: String
  
  /// Full name of the repository (owner+name).
  public var fullName: String
  
  /// Issues of the repository.
  public var issues: [Issue]
  
  /// Labels of the repository.
  public var labels: [Label]
  
  /// Milestones of the repository
  public var milestones: [Milestone]
  
  public init(id: Int, owner: User, name: String, fullName: String, issues: [Issue] = [], labels: [Label] = [], milestones: [Milestone] = []) {
    self.id = id
    self.owner = owner
    self.name = name
    self.fullName = fullName
    
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

// MARK: - CustomStringConvertible
extension GitHubRepository: CustomStringConvertible, Printable {
  
  /// A textual representation of `self`.
  public var description: String {
    return "\(self.file): [\(self.id)] \(self.fullName)"
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
  return lhs.id == rhs.id
}