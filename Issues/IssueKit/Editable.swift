//
//  Editable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Editable {
  
  mutating func close(withComment comment: String?)
  mutating func reopen(withComment comment: String?)
  
  mutating func editTitle(title: String)
  mutating func editBody(body: String)
  
  mutating func addMilestone(milestone: Milestone) throws
  mutating func editMilestone(milestone: Milestone) throws
  
  mutating func addLabel(label: Label)
  mutating func addLabels(labels: Set<Label>)
  
  mutating func removeLabel(label: Label)
  mutating func removeLabels(labels: Set<Label>)
  
  mutating func replaceLabels(withLabels labels: Set<Label>)
  mutating func removeLabels()
}

extension Editable {
  
  /// Adds the labels to the issue.
  ///
  /// - Parameter labels: set of labels to add to the issue.
  public mutating func addLabels(labels: Set<Label>) {
    for label in labels {
      self.addLabel(label)
    }
  }
  
  /// Removes the labels to the issue.
  ///
  /// - Parameter labels: set of labels to remove from the issue.
  public mutating func removeLabels(labels: Set<Label>) {
    for label in labels {
      self.removeLabel(label)
    }
  }
}