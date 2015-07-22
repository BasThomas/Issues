//
//  IssueController.swift
//  Issues
//
//  Created by Bas on 07/07/2015.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct IssueController {
  public var issues: [Issue] = []
  
  public mutating func addIssue(issue: Issue) {
    self.issues.append(issue)
  }
  
  public func issuesWithLabels(labels: [Label]) -> [Issue] {
    return []
  }
  
  public func issuesWithLabel(label: Label) -> [Issue] {
    return self.issuesWithLabels([label])
  }
  
  public func issuesWithMilestone(milestone: Milestone) -> [Issue] {
    return []
  }
}

extension IssueController {
  public var openIssues: [Issue] {
    var issues: [Issue] = []
    
    for issue in self.issues where issue.state == .Open {
      issues.append(issue)
    }
    
    return issues
  }
  
  public var closedIssues: [Issue] {
    var issues: [Issue] = []
    
    for issue in self.issues where issue.state == .Closed {
      issues.append(issue)
    }
    
    return issues
  }
  
  public var lockedIssues: [Issue] {
    var issues: [Issue] = []
    
    for issue in self.issues where issue.state == .Locked {
      issues.append(issue)
    }
    
    return issues
  }
  
  public var unlockedIssues: [Issue] {
    var issues: [Issue] = []
    
    for issue in self.issues where issue.state != .Locked {
      issues.append(issue)
    }
    
    return issues
  }
}