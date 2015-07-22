//
//  Assignable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Assignable {
  
  func addAssignee(assignee: Assignee)
  func addAssignees(assignees: [Assignee])
  
  func removeAssignee(assignee: Assignee)
  func removeAssignees(assignees: [Assignee])
}

extension Assignable {
  
  public func addAssignees(assignees: [Assignee]) {
    for assignee in assignees {
      self.addAssignee(assignee)
    }
  }
  
  public func removeAssignees(assignees: [Assignee]) {
    for assignee in assignees {
      self.removeAssignee(assignee)
    }
  }
}