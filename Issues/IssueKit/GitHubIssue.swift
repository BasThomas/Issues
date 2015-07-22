//
//  GitHubIssue.swift
//  Issues
//
//  Created by Bas Broek on 11/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct GitHubIssue: Issue {
  
  public var number: Int
  public var title: String
  public var body: String
  public var state: State
  
  public var comments: [Comment]
  public var assignees: [Assignee]
  public var labels: [Label]
  public var milestone: Milestone
  
  public var creationDate: NSDate
  public var closingDate: NSDate?
}

extension GitHubIssue: Editable {
  
  public func open(withTitle title: String, body: String? = nil) {
//    POST /repos/:owner/:repo/issues
    
//    {
//      "title": "Found a bug",
//      "body": "I'm having a problem with this.",
//      "assignee": "octocat",
//      "milestone": 1,
//      "labels": [
//      "Label1",
//      "Label2"
//      ]
//    }
  }
  
  public func close(withBody body: String? = nil) {
//    PATCH /repos/:owner/:repo/issues/:number
    
//    {
//      "title": "Found a bug",
//      "body": "I'm having a problem with this.",
//      "assignee": "octocat",
//      "milestone": 1,
//      "state": "closed",
//      "labels": [
//      "Label1",
//      "Label2"
//      ]
//    }
  }
  
  public func reopen(withBody body: String? = nil) {
//    PATCH /repos/:owner/:repo/issues/:number
    
//    {
//      "title": "Found a bug",
//      "body": "I'm having a problem with this.",
//      "assignee": "octocat",
//      "milestone": 1,
//      "state": "open",
//      "labels": [
//      "Label1",
//      "Label2"
//      ]
//    }
  }
  
  public func editTitle(title: String) {
    
  }
  
  public func editBody(body: String) {
    
  }
  
  public func addMilestone(milestone: Milestone) {
    
  }
  
  public func editMilestone(milestone: Milestone) {
    
  }
  
  public func addLabel(label: Label) {
//    POST /repos/:owner/:repo/issues/:number/labels
    
//    [
//      "Label1",
//      "Label2"
//    ]
  }
  
  public func removeLabel(label: Label) {
//    DELETE /repos/:owner/:repo/issues/:number/labels/:name
  }
  
  public mutating func replaceLabels(withLabels labels: [Label]) {
    self.labels = labels
  }
  
  public mutating func removeLabels() {
    self.labels = []
  }
}

extension GitHubIssue: Commentable {
  
  public func comment(body: String) {
//    POST /repos/:owner/:repo/issues/:number/comments

//    {
//      "body": "Me too"
//    }
  }
  
  public func editComment(comment: Comment, body: String) {
//    PATCH /repos/:owner/:repo/issues/comments/:id
    
//    {
//      "body": "Me too"
//    }
  }
  
  public func deleteComment(comment: Comment) {
//    DELETE /repos/:owner/:repo/issues/comments/:id
  }
}

extension GitHubIssue: Lockable {
  
  public func lock() {
    
  }
  
  public func unlock() {
    
  }
}

extension GitHubIssue: Assignable {
  
  public func addAssignee(assignee: Assignee) {
    
  }
  
  public func removeAssignee(assignee: Assignee) {
    
  }
}