//
//  Editable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Editable {
  
  func open(withTitle title: String, body: String?)
  func close(withBody body: String?)
  func reopen(withBody body: String?)
  
  func editTitle(title: String)
  func editBody(body: String)
  
  func addMilestone(milestone: Milestone)
  func editMilestone(milestone: Milestone)
  
  func addLabel(label: Label)
  func addLabels(labels: Set<Label>)
  
  func removeLabel(label: Label)
  func removeLabels(labels: Set<Label>)
  
  mutating func replaceLabels(withLabels labels: Set<Label>)
  mutating func removeLabels()
}

extension Editable {
  
  public func addLabels(labels: Set<Label>) {
    for label in labels {
      self.addLabel(label)
    }
  }
  
  public func removeLabels(labels: Set<Label>) {
    for label in labels {
      self.removeLabel(label)
    }
  }
}