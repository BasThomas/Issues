//
//  Assignable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Assignable {
  
  mutating func replaceAssignee(assignee: Assignee)
  
  mutating func removeAssignee()
}