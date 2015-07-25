//
//  ParameterValues.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct Value {
  
  public struct OAuth {
    
    public static let AccessToken = ClientAccessToken
  }
  
  public struct Sort {
    
    public static let Pushed = "pushed"
    public static let FullName = "full_name"
    
    public static let DueDate = "due_date"
    public static let Completeness = "completeness"
    
    public static let Updated = "updated"
    public static let Comments = "comments"
    
    public static let Assigned = "assigned"
    public static let Created = "created"
    public static let Mentioned = "mentioned"
    public static let Subscribed = "subscribed"
    public static let All = "all"
  }
  
  public struct Direction {
    
    public static let Ascending = "asc"
    public static let Descending = "desc"
  }
  
  public enum State: String, StringRawRepresentable, LowercaseInitializable {
    
    case Open
    case Closed
    case All
    
    /// All values of the enum.
    public static let allValues = [Open, Closed, All]
  }
  
  public enum Visibility: String, StringRawRepresentable, LowercaseInitializable {
    
    case All
    case Public
    case Private
    
    /// All values of the enum.
    public static let allValues = [All, Public, Private]
  }
  
  public struct Affiliation {
    
    public static let Owner = "owner"
    public static let Collaborator = "collaborator"
    public static let OrganizationMember = "organization_member"
  }
  
  public enum Type: String, StringRawRepresentable, LowercaseInitializable {
    
    case All
    case Owner
    case Public
    case Private
    case Forks
    case Sources
    case Member
    
    /// All values of the enum.
    public static let allValues = [All, Owner, Public, Private, Forks, Sources, Member]
  }
}
