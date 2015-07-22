//
//  Milestoneable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol MilestoneAble {
  
  func createMilestone(milestone: Milestone)
  func editMilestone(milestone: Milestone, withMilestone editedMilestone: Milestone)
  func deleteMilestone(milestone: Milestone)
}