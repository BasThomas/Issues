//
//  ParameterNames.swift
//  Issues
//
//  Created by Bas Broek on 24/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

// MARK: - OAuth
public enum OAuth: String, StringRawRepresentable, LowercaseInitializable {
  
  /// [string] access token of the user.
  case AccessToken = "access_token"
  
  /// All values of the enum.
  public static let allValues = [AccessToken]
}

// MARK: LowercaseInitializable
extension OAuth {
  
  public init?<T: Equatable>(rawValue: T) {
    // Returns .AccessToken when the rawValue corresponds to the case.
    // This is needed because of the custom rawValue.
    guard (rawValue as? String)?.lowercaseString != "AccessToken".lowercaseString else { self = AccessToken; return }
    
    let value = OAuth.allValues.filter { ($0.rawValue as String).lowercaseString == (rawValue as? String)?.lowercaseString }
    
    if let state = value.first {
      self = state
    } else {
      return nil
    }
  }
}

// MARK: - Issues
public enum Issues: String, StringRawRepresentable, LowercaseInitializable {
  
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
  
  /// All values of the enum.
  public static let allValues = [Filter, State, Labels, Sort, Direction, Since]
}

// MARK: - Comments
public enum Comments: String, StringRawRepresentable, LowercaseInitializable {
  
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
  
  /// All values of the enum.
  public static let allValues = [Sort, Direction, Since]
}

// MARK: - Labels
public enum Labels: String, LowercaseInitializable {
  
  /// [string] name of the label.
  case Name
  
  /// [string] six character hex code, without the leading `#`, identifying the color.
  case Color
  
  /// All values of the enum.
  public static let allValues = [Name, Color]
}

// MARK: - Milestones
public enum Milestones: String, StringRawRepresentable, LowercaseInitializable {
  
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
  
  /// All values of the enum.
  public static let allValues  = [SortState, Sort, Direction, Title, State, Description, DueOn]
}

// MARK: LowercaseInitializable
extension Milestones {
  
  public init?<T: Equatable>(rawValue: T) {
    // Returns .DueOn when the rawValue corresponds to the case.
    // This is needed because of the custom rawValue.
    guard (rawValue as? String)?.lowercaseString != "due_on".lowercaseString else { self = DueOn; return }
    
    let value = Milestones.allValues.filter { ($0.rawValue as String).lowercaseString == (rawValue as? String)?.lowercaseString }
    
    if let state = value.first {
      self = state
    } else {
      return nil
    }
  }
}

// MARK: - Repositories
public enum Repositories: String, StringRawRepresentable, LowercaseInitializable {
  
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
  // _Type because `Type` can't be used.
  case _Type = "type"
  
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
  
  /// All values of the enum.
  public static let allValues = [Visibility, Affiliation, _Type, Sort, Direction, Since, Anon]
}

// MARK: LowercaseInitializable
extension Repositories {
  
  public init?<T: Equatable>(rawValue: T) {
    // Returns ._Type when the rawValue corresponds to the case.
    // This is needed because of the custom rawValue.
    guard (rawValue as? String)?.lowercaseString != "_Type".lowercaseString else { self = _Type; return }
    
    let value = Repositories.allValues.filter { ($0.rawValue as String).lowercaseString == (rawValue as? String)?.lowercaseString }
    
    if let state = value.first {
      self = state
    } else {
      return nil
    }
  }
}