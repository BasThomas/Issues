//
//  Milestone.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Milestone: CustomStringConvertible {
  
  var id: Int? { get }
  var title: String { get }
  var state: State { get }
  var _description: String? { get }
  var dueDate: NSDate? { get }
}