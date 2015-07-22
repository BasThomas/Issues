//
//  Milestoneable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Milestoneable {
  
  mutating func addMilestone(milestone: Milestone)
  func editMilestone(milestone: Milestone, withMilestone editedMilestone: Milestone)
  mutating func removeMilestone(milestone: Milestone)
}