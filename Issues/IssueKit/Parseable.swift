//
//  Parseable.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation
import SwiftyJSON

public typealias Parameters = [String: AnyObject]

public protocol Parseable {
  
  func parseIssues(json: JSON) -> [Issue]
  func parseUserIssues(json: JSON) -> [Issue]
  
  func parseIssueParameterOptions(parameterOptions: IssueParameterOptions) -> Parameters
}