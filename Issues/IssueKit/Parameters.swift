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
  /// **Default:**
  ///
  /// `assigned`
  case Filter
  
  /// [string] indicates the state of the issues to return.
  ///
  /// - `open`  : open issues.
  /// - `closed`: closed issues.
  /// - `all`   : all issues.
  ///
  /// **Default:**
  ///
  /// `open`
  case State
  
  /// [string] list of comma separated label names.
  ///
  /// **Example:**
  ///
  /// `bug,ui,help`
  case Labels
  
  /// [string] what to sort results by.
  ///
  /// - `created` : sort by date of creation.
  /// - `updated` : sort by date of last update.
  /// - `comments`: sort by amount of comments.
  ///
  /// **Default:**
  ///
  /// `created`
  case Sort
  
  /// [string] direction of the sort.
  ///
  /// - `asc` : sorts in ascending order.
  /// - `desc`: sorts in descending order.
  ///
  /// **Default:**
  ///
  /// `desc`
  case Direction
  
  /// [string] only issues updated at or after this time are returned.
  ///
  /// - Note: this is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
  case Since
}

// MARK: StringRawable
extension Issues: StringRawPresentable {
  
  /// The corresponding value of the "raw" type.
  public var string: String {
    return self.rawValue.lowercaseString
  }
}

// MARK: - Comments
public enum Comments: String {
  
  /// [string] what to sort results by.
  ///
  /// - `created`: sort by date of creation.
  /// - `updated`: sort by date of last update.
  ///
  /// **Default:**
  ///
  /// `created`
  case Sort
  
  /// [string] direction of the sort.
  ///
  /// - `asc` : sorts in ascending order.
  /// - `desc`: sorts in descending order.
  ///
  /// **Default:**
  ///
  /// `asc`
  ///
  /// - Note: ignored without the `sort` parameter.
  case Direction
  
  /// [string] only comments updated at or after this time are returned.
  ///
  /// - Note: this is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
  case Since
}

// MARK: StringRawable
extension Comments: StringRawPresentable {
  
  /// The corresponding value of the "raw" type.
  public var string: String {
    return self.rawValue.lowercaseString
  }
}

// MARK: - Labels
public enum Labels: String {
  
  /// [string] name of the label.
  case Name
  
  /// [string] six character hex code, without the leading `#`, identifying the color.
  case Color
}

// MARK: StringRawable
extension Labels: StringRawPresentable {
  
  /// The corresponding value of the "raw" type.
  public var string: String {
    return self.rawValue.lowercaseString
  }
}

// MARK: - Milestones
public enum Milestones: String {
  
  // Listing
  
  /// [string] indicates the state of the milestones to return.
  ///
  /// - `open`  : open milestones.
  /// - `closed`: closed milestones.
  /// - `all`   : all milestones.
  ///
  /// **Default:**
  ///
  /// `open`
  case SortState
  
  /// [string] what to sort the results by.
  ///
  /// - `due_date`    : due date of the milestone.
  /// - `completeness`: completion percentage of the milestone.
  ///
  /// **Default:**
  ///
  /// `due_date`
  case Sort
  
  /// [string] direction of the sort.
  ///
  /// - `asc` : sorts in ascending order.
  /// - `desc`: sorts in descending order.
  ///
  /// **Default:**
  ///
  /// `asc`
  case Direction
  
  // Creating
  
  /// [string] title of the milestone.
  case Title
  
  /// [string] state of the milestone.
  ///
  /// - `open`  : open milestones.
  /// - `closed`: closed milestones.
  ///
  /// **Default:**
  ///
  /// `open`
  case State
  
  /// [string] description of the milestone.
  case Description
  
  /// [string] due date of the milstone.
  ///
  /// - Note: this is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
  case DueOn = "due_on"
}

// MARK: StringRawable
extension Milestones: StringRawPresentable {
  
  /// The corresponding value of the "raw" type.
  public var string: String {
    return self.rawValue.lowercaseString
  }
}

// MARK: - Repositories
public enum Repositories: String {
  
  // Listing
  
  /// [string] visibility of the repository.
  ///
  /// - `all`    : both public and private visibility.
  /// - `public` : public visibility.
  /// - `private`: private visibility.
  ///
  /// **Default:**
  ///
  /// `all`
  case Visibility
  
  /// [string] comma-seperated list of values.
  ///
  /// - `owner`              : repositories that are owned by the authenticated user.
  /// - `collaborator`       : repositories that the authenticated user has been added to as a collaborator.
  /// - `organization_member`: repositories that the authenticated user has access to through being a member of an organization;
  ///                          this includes every repository on every team that the authenticated user is on.
  ///
  /// **Default:**
  ///
  /// `owner,collaborator,organization_member`
  case Affiliation
  
  /// [string] type of the repository.
  ///
  /// - `all`    : all the authenticated user's repositories.
  /// - `owner`  : repositories that the authenticated user owns.
  /// - `public` : public repositories of the authenticated user.
  /// - `private`: private repositires of the authenticated user.
  /// - `forks`  : forked repositories of the organization
  /// - `sources`: ???
  /// - `member` : repositories the authenticated user is a member in.
  ///
  /// **Default:**
  ///
  /// `all`
  ///
  /// - Warning: will cause a `422` error if used in the same request as `visibility` or `affiliation`.
  case Type
  
  /// [string] what to sort the results by.
  ///
  /// - `created`  : creation date of the repository.
  /// - `updated`  : last updated date of the repository.
  /// - `pushed`   : last pushed date of the repository.
  /// - `full_name`: name of the repository.
  ///
  /// **Default:**
  ///
  /// `full_name`
  case Sort
  
  /// [string] direction of the sort.
  ///
  /// - `asc` : sorts in ascending order.
  /// - `desc`: sorts in descending order.
  ///
  /// **Default:**
  ///
  /// when using `full_name`: `asc`; otherwise `desc`
  case Direction
  
  /// [string] integer ID of the last repository the authenticated user has seen.
  case Since
  
  /// [string] includes anonymous contributors in results.
  ///
  /// - Note: must be set to `1` or `true` to include anonymous contributors.
  case Anon
}

// MARK: StringRawable
extension Repositories: StringRawPresentable {
  
  /// The corresponding value of the "raw" type.
  public var string: String {
    return self.rawValue.lowercaseString
  }
}