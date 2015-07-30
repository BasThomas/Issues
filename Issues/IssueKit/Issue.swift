//
//  Issue.swift
//  Issues
//
//  Created by Bas on 06/07/2015.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Issue: CustomStringConvertible {
  
  var id: Int { get }
  var repository: Repository { get }
  var number: Int { get }
  var title: String { get }
  var body: String { get }
  var state: State { get }
  var locked: Bool { get }
  
  var comments: [Comment] { get set }
  var assignees: Set<Assignee> { get set }
  var labels: Set<Label> { get set }
  var milestone: Milestone? { get set }
  
  var creationDate: NSDate { get }
  var closingDate: NSDate? { get }
}