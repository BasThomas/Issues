//
//  GitHubMilestone.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct GitHubMilestone: Milestone {
  
  /// ID of the milestone.
  public var id: Int?
  
  /// Title of the milestone.
  public var title: String
  
  /// State of the milestone.
  public var state: State
  
  /// Description of the milestone.
  public var description: String?
  
  /// Due date of the milestone.
  public var dueDate: NSDate?
}

// MARK: - Hashable
extension GitHubMilestone: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return self.title.hashValue ^ self.state.hashValue
  }
}

// MARK: - Equatable
extension GitHubMilestone: Equatable { }

public func ==(lhs: GitHubMilestone, rhs: GitHubMilestone) -> Bool {
  return lhs.id == rhs.id &&
    lhs.title == rhs.title &&
    lhs.state == rhs.state &&
    lhs.description == rhs.description &&
    lhs.dueDate == rhs.dueDate
}