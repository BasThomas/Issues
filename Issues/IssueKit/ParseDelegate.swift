//
//  ParseDelegate.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

protocol ParseDelegate {
  
  func parsedIssues(issues: [Issue])
}