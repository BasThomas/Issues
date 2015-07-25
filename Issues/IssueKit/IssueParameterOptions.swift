//
//  IssueParameterOptions.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct IssueParameterOptions {
  
  let filter: String
  let state: String
  let labels: String
  let sort: String
  let direction: String
  let since: String
  
  public init(filter: String = "", state: String = "", labels: [Label]? = nil, sort: String = "", direction: String = "", since: NSDate? = nil) {
    func labelsToCommaSeperatedString(labels: [Label]?) -> String {
      guard let labels = labels else { return "" }
      
      return ",".join(labels.map { $0.name })
    }
    
    self.filter = filter
    self.state = state
    self.labels = labelsToCommaSeperatedString(labels)
    self.sort = sort
    self.direction = direction
    self.since = since?.stringValue ?? ""
  }
}