//
//  GitHubRepository.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct GitHubRepository: Repository {
  
}

extension GitHubRepository: Labelable {
  
  public func createLabel(label: Label) {
//    POST /repos/:owner/:repo/labels
  }
  
  public func editLabel(label: Label, withLabel editedLabel: Label) {
//    PATCH /repos/:owner/:repo/labels/:name
  }
  
  public func deleteLabel(label: Label) {
//    DELETE /repos/:owner/:repo/labels/:name
  }
}

extension GitHubRepository: MilestoneAble {
  
  public func createMilestone(milestone: Milestone) {
//    POST /repos/:owner/:repo/milestones
    
//    {
//      "title": "v1.0",
//      "state": "open",
//      "description": "Tracking milestone for version 1.0",
//      "due_on": "2012-10-09T23:39:01Z"
//    }
  }
  
  public func editMilestone(milestone: Milestone, withMilestone editedMilestone: Milestone) {
//    PATCH /repos/:owner/:repo/milestones/:number
  }
  
  public func deleteMilestone(milestone: Milestone) {
//    DELETE /repos/:owner/:repo/milestones/:number
  }
}