//
//  Issue.swift
//  Issues
//
//  Created by Bas on 06/07/2015.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Issue {
  /* VARIABLES */
  var number: Int { get }
	var title: String { get set }
  var body: String { get set }
	var state: State { get set }
  
	var labels: [Label] { get set }
	var milestone: Milestone { get set }
  var canAssign: Bool { get }
  var locked: Bool { get }
  
  var creationDate: NSDate { get }
  var closeDate: NSDate { get }
  
  /* FUNCTIONS */
  func open(withTitle title: String, message: String)
  func respond(message: String)
  func close(withMessage message: String?)
  func reopen(withMessage message: String?)
  func lock()
  func unlock()
  
  func addLabel(label: Label)
  func addLabels(labels: [Label])
  
  func addMilestone(milestone: Milestone)
  func addAssignee(assignee: Assignable)
}

extension Issue where Self: Assignable {
  var canAssign: Bool { return true }
}

public protocol Assignable {
  /* VARIABLES */
  var assignee: User { get set }
}