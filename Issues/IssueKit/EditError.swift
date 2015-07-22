//
//  EditError.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public enum EditError: ErrorType {
  
  case MilestoneAlreadyAdded(milestone: Milestone!)
  case MilestoneMissing
  case Unknown
}