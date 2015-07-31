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
  public var _description: String?
  
  /// Due date of the milestone.
  public var dueDate: NSDate?
  
  public init(id: Int, title: String, state: State, description: String?, dueDate: NSDate?) {
    self.id = id
    self.title = title
    self.state = state
    self._description = description
    self.dueDate = dueDate
  }
}

// MARK: - CustomStringConvertible
extension GitHubMilestone: CustomStringConvertible, Printable {
  
  /// A textual representation of `self`.
  public var description: String {
    return "\(self.file): [\(self.id)] \(self.title), state: \(self.state), description: \(self._description), dueDate: \(self.dueDate)"
  }
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