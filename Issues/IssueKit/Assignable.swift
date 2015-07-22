//
//  Assignable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Assignable {
  
  mutating func addAssignee(assignee: Assignee)
  mutating func addAssignees(assignees: Set<Assignee>)
  
  mutating func removeAssignee(assignee: Assignee) -> Bool
  mutating func removeAssignees(assignees: Set<Assignee>)
}

extension Assignable {
  
  /// Adds a set of assignees.
  ///
  /// - Parameter assignees: the assignees to add.
  public mutating func addAssignees(assignees: Set<Assignee>) {
    for assignee in assignees {
      self.addAssignee(assignee)
    }
  }
  
  /// Removes a set of assignees.
  ///
  /// - Parameter assignees: the assignees to remove.
  public mutating func removeAssignees(assignees: Set<Assignee>) {
    for assignee in assignees {
      self.removeAssignee(assignee)
    }
  }
}