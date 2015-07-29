//
//  IssueParameterOptions.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct IssueParameterOptions: ParameterOptions {
  
  let filter: String
  let state: String
  let labels: String
  let sort: String
  let direction: String
  let since: String
  
  public init(filter: String = Value.Sort.All, state: String = "", labels: [Label]? = nil, sort: String = "", direction: String = "", since: NSDate? = nil) {
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

// MARK: - Hashable
extension IssueParameterOptions: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return self.filter.hashValue ^ self.state.hashValue ^ self.labels.hashValue ^ self.sort.hashValue ^ self.direction.hashValue ^ self.since.hashValue
  }
}

// MARK: - Equatable
extension IssueParameterOptions: Equatable {}

public func ==(lhs: IssueParameterOptions, rhs: IssueParameterOptions) -> Bool {
  return lhs.filter == rhs.filter &&
    lhs.state == rhs.state &&
    lhs.labels == rhs.labels &&
    lhs.sort == rhs.sort &&
    lhs.direction == rhs.direction &&
    lhs.since == rhs.since
}