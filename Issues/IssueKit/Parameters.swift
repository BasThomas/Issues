//
//  Parameters.swift
//  Issues
//
//  Created by Bas Broek on 24/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

// MARK: Issues

public enum Issues: String {
  
  /// [string] indicates which sort of issues to return.
  ///
  /// - `assigned`  : issues assigned to you.
  /// - `created`   : issues created by you.
  /// - `mentioned` : issues mentioning you.
  /// - `subscribed`: issues you’re subscribed to updates for.
  /// - `all`       : all issues the authenticated user can see, regardless of participation or creation.
  ///
  /// **Default**:
  ///
  /// `assigned`
  case Filter
  
  /// [string] indicates the state of the issues to return.
  ///
  /// - `open`  : open issues.
  /// - `closed`: closed issues.
  /// - `all`   : all issues.
  ///
  /// **Default**:
  ///
  /// `open`
  case State
  
  /// [string] list of comma separated label names.
  ///
  /// **Example**:
  ///
  /// `bug,ui,help`
  case Labels
  
  /// [string] what to sort results by.
  ///
  /// - `created` : sort by date of creation.
  /// - `updated` : sort by date of last update.
  /// - `comments`: sort by amount of comments.
  ///
  /// **Default**:
  ///
  /// `created`
  case Sort
  
  /// [string] direction of the sort.
  ///
  /// - `asc` : sorts in ascending order.
  /// - `desc`: sorts in descending order.
  ///
  /// **Default**:
  ///
  /// `desc`
  case Direction
  
  /// [string] only issues updated at or after this time are returned.
  ///
  /// - Note: This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
  case Since
}