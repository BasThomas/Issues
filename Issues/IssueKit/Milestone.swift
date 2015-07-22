//
//  Milestone.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Milestone {
  
  var title: String { get }
  var state: State { get }
  var description: String? { get }
  var dueDate: NSDate? { get }
}