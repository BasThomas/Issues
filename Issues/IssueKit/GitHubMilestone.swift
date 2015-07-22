//
//  GitHubMilestone.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct GitHubMilestone: Milestone {
  
  public var title: String
  public var state: State
  public var description: String?
  public var dueDate: NSDate?
}