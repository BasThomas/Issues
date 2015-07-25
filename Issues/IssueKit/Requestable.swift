//
//  Requestable.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Requestable {
  
  func requestIssues(parameterOptions: IssueParameterOptions)
  func requestUserIssues(parameterOptions: IssueParameterOptions)
}