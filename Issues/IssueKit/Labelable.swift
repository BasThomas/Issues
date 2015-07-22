//
//  Labelable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Labelable {
  
  func createLabel(label: Label)
  func editLabel(label: Label, withLabel editedLabel: Label)
  func deleteLabel(label: Label)
}