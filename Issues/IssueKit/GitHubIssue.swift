//
//  GitHubIssue.swift
//  Issues
//
//  Created by Bas Broek on 11/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

private let Now = NSDate()

public struct GitHubIssue: Issue {
  
  /// Unique id.
  public var id: Int
  
  /// Associated repository.
  public var repository: Repository
  
  /// Number to identify the issue in a repository.
  public var number: Int
  
  /// Title of the issue.
  public var title: String
  
  /// Body of the issue, if any.
  public var body: String
  
  /// State of the issue. Either `Open` or `Closed`
  public var state: State
  
  /// Tracks if the issue is locked or not.
  public var locked: Bool
  
  /// Comments' URL.
  public var commentsURL: String
  
  /// Comment(s) accompanying the issue.
  public var comments: [Comment]
  
  /// Assigignee assigned to the issue.
  public var assignee: Assignee?
  
  /// Label(s) accompanying the issue.
  public var labels: Set<Label>
  
  /// Milestone of the issue, if any.
  public var milestone: Milestone?
  
  /// The creation date of the issue.
  public var creationDate: NSDate
  
  /// The closing date of the issue, if any.
  public var closingDate: NSDate?
  
  public init(id: Int, repository: Repository, number: Int, title: String, body: String = "", state: State = .Open, locked: Bool = false, commentsURL: String, comments: [GitHubComment] = [], assignee: Assignee? = nil, labels: Set<Label> = [], milestone: GitHubMilestone? = nil, creationDate: NSDate, closingDate: NSDate? = nil) {
    self.id = id
    self.repository = repository
    self.number = number
    self.title = title
    self.body = body
    self.state = state
    self.locked = locked
    
    let _comments: [Comment] = comments.map { $0 } // Workaround, as [GitHubComment] != [Comment], apparently.
    
    self.commentsURL = commentsURL
    self.comments = _comments
    self.assignee = assignee
    self.labels = labels
    self.milestone = milestone
    
    self.creationDate = creationDate
    self.closingDate = closingDate
  }
}

// MARK: - Editable
extension GitHubIssue: Editable {
  
  /// Closes an issue, optionally with a comment.
  ///
  /// - Parameter comment: comment to place with the closing of the issue.
  public mutating func close(withComment comment: String? = nil) {
    self.state = .Closed
    
    if let comment = comment {
      self.comment(comment)
    }
    
//    PATCH /repos/:owner/:repo/issues/:number
    
//    {
//      "state": "closed"
//    }
  }
  
  /// Reopens an issue, optionally with a comment.
  ///
  /// - Parameter comment: comment to place with the reopening of the issue.
  public mutating func reopen(withComment comment: String? = nil) {
    self.state = .Open
    
    if let comment = comment {
      self.comment(comment)
    }
    
//    PATCH /repos/:owner/:repo/issues/:number
    
//    {
//      "state": "open"
//    }
  }
  
  /// Edits the title of the issue.
  ///
  /// - Parameter title: string to replace the title with.
  public mutating func editTitle(title: String) {
    self.title = title
    
//    PATCH /repos/:owner/:repo/issues/:number

//    {
//      "title": "title"
//    }
  }
  
  /// Edits the body of the issue.
  ///
  /// - Parameter body: string to replace the body with.
  public mutating func editBody(body: String) {
    self.body = body
    
//    PATCH /repos/:owner/:repo/issues/:number

//    {
//      "body": "body"
//    }
  }
  
  /// Adds a milestone to the issue.
  ///
  /// - Parameter milestone: milestone to add.
  ///
  /// - Throws: `MilestoneAlreadyAdded` when a milestone has previously been added. Use `editMilestone(:)` instead.
  public mutating func addMilestone(milestone: Milestone) throws {
    guard self.milestone == nil else { throw EditError.MilestoneAlreadyAdded(milestone: self.milestone) }
    
    self.milestone = milestone
  }
  
  /// Edits a milestone of the issue.
  ///
  /// - Parameter milestone: milestone to replace the current milestone.
  ///
  /// - Throws: `MilestoneMissing` when no milestone has been added yet. Use `addMilestone(:)` instead.
  public mutating func editMilestone(milestone: Milestone) throws {
    guard let _ = self.milestone else { throw EditError.MilestoneMissing }
    
    self.milestone = milestone
  }
  
  /// Adds a label to the issue.
  ///
  /// - Parameter label: label to add to the issue.
  public mutating func addLabel(label: Label) {
    self.labels.insert(label)
    
//    POST /repos/:owner/:repo/issues/:number/labels
    
//    [
//      "Label1",
//      "Label2"
//    ]
  }
  
  /// Removes a label from the issue.
  ///
  /// - Parameter label: label to remove from the issue.
  public mutating func removeLabel(label: Label) {
    self.labels.remove(label)
    
//    DELETE /repos/:owner/:repo/issues/:number/labels/:name
    
//    OR
    
//    PATCH /repos/:owner/:repo/issues/:number
    
//    {
//      "labels": []
//    }
  }
  
  /// Replaces the labels with a new set of labels.
  ///
  /// - Parameter labels: set of labels to replace the current lables with.
  public mutating func replaceLabels(withLabels labels: Set<Label>) {
    self.labels = labels
  }
  
  /// Removes all labels from the issue.
  public mutating func removeLabels() {
    self.labels = []
  }
}

// MARK: - Commentable
extension GitHubIssue: Commentable {
  
  /// Adds a comment to the issue.
  ///
  /// - Parameter body: body of the comment.
  public func comment(body: String) {
//    POST /repos/:owner/:repo/issues/:number/comments

//    {
//      "body": "Me too"
//    }
  }
  
  /// Edits the given comment with a new body.
  ///
  /// - Parameter comment: comment to edit.
  /// - Parameter body: body of the comment.
  public func editComment(comment: Comment, body: String) {
//    PATCH /repos/:owner/:repo/issues/comments/:id
    
//    {
//      "body": "Me too"
//    }
  }
  
  /// Deletes the given comment from the issue.
  ///
  /// - Parameter comment: comment to remove.
  public func deleteComment(comment: Comment) {
//    DELETE /repos/:owner/:repo/issues/comments/:id
  }
}

// MARK: - Lockable
extension GitHubIssue: Lockable {
  
  /// Locks the issue.
  public mutating func lock() {
    self.locked = true
  }
  
  /// Unlocks the issue.
  public mutating func unlock() {
    self.locked = false
  }
}

// MARK: - Assignable
extension GitHubIssue: Assignable {
  
  /// Removes the assignee to the issue.
  ///
  /// - Parameter assignee: assignee to remove.
  ///
  /// - Returns `Bool` true if the assignee could be removed, else false.
  public mutating func removeAssignee() {
    return self.assignee = nil
  }
  
  public mutating func replaceAssignee(assignee: Assignee) {
    self.assignee = assignee
  }
}

// MARK: - CustomStringConvertible
extension GitHubIssue: CustomStringConvertible, Printable {
  
  /// A textual representation of `self`.
  public var description: String {
    return "\(self.file): [\(self.id)] \(self.title) (#\(self.number) in \(self.repository.name))"
  }
}

// MARK: - Hashable
extension GitHubIssue: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return self.id.hashValue
  }
}

// MARK: - Equatable
extension GitHubIssue: Equatable { }

public func ==(lhs: GitHubIssue, rhs: GitHubIssue) -> Bool {
  return lhs.id == rhs.id
}