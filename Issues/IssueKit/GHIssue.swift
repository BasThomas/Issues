//
//  GHIssue.swift
//  Issues
//
//  Created by Bas Broek on 11/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct GHIssue: Issue {
  public var number = 1
  public var title = ""
  public var body = ""
  public var state: State = .Open
  
  public var labels: [Label] = []
  public var milestone: Milestone = ""
  public var canAssign = false
  public var locked = true
  
  public var creationDate = NSDate()
  public var closeDate: NSDate?
  
  public init(number: Int, title: String, body: String, state: State, labels: [Label] = [], milestone: Milestone = "", canAssign: Bool = false, locked: Bool = false, creationDate: NSDate, closeDate: NSDate?) {
    self.number = number
    self.title = title
    self.body = body
    self.state = state
    self.labels = labels
    self.milestone = milestone
    self.canAssign = canAssign
    self.locked = locked
    self.creationDate = creationDate
    self.closeDate = closeDate
  }
}

extension GHIssue {
  public func open(withTitle title: String, message: String) {
    //
  }
  
  public func respond(message: String) {
    //
  }
  
  public func close(withMessage message: String?) {
    //
  }
  
  public func reopen(withMessage message: String?) {
    //
  }
  
  public func lock() {
    //
  }
  
  public func unlock() {
    //
  }
  
  public func addLabel(label: Label) {
    //
  }
  
  public func addLabels(labels: [Label]) {
    //
  }
  
  public func addMilestone(milestone: Milestone) {
    //
  }
  
  public func addAssignee(assignee: Assignable) {
    //
  }
}