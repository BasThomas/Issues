//
//  Repository.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Repository {
  
  var owner: String { get }
  var name: String { get }
  var fullName: String { get }
  
  var issues: [Issue] { get set }
  var labels: [Label] { get set }
  var milestones: [Milestone] { get set }
  
  var openIssues: [Issue] { get }
  var closedIssues: [Issue] { get }
  var lockedIssues: [Issue] { get }
  var unlockedIssues: [Issue] { get }
  
  func issuesWithLabel(label: Label) -> [Issue]
  func issuesWithLabels(labels: [Label]) -> [Issue]
  
  func issuesWithMilestone(milestone: Milestone) -> [Issue]
}

extension Repository {
  
  /// All open issues of the repository.
  public var openIssues: [Issue] {
    return self.issues.filter { $0.state == .Open }
  }
  
  /// All closed issues of the repository.
  public var closedIssues: [Issue] {
    return self.issues.filter { $0.state == .Closed }
  }
  
  /// All locked issues of the repository.
  public var lockedIssues: [Issue] {
    return self.issues.filter { $0.locked }
  }
  
  /// All unlocked issues of the repository.
  public var unlockedIssues: [Issue] {
    return self.issues.filter { !$0.locked }
  }
  
  /// Gets an array of issues with the specific label.
  ///
  /// - Parameter label: label to search for.
  ///
  /// - Returns `[Issue]` the found issues.
  public func issuesWithLabel(label: Label) -> [Issue] {
    return self.issuesWithLabels([label])
  }
}