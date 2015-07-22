//
//  Labelable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Labelable {
  
  mutating func addLabel(label: Label)
  func editLabel(label: Label, withLabel editedLabel: Label)
  mutating func removeLabel(label: Label)
}