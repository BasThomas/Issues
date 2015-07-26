//
//  RequestController.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation
import Alamofire

/// Parse instance.
private let Parse = ParseController.sharedInstance

/// Authorization key-value pair.
private let Authorization = [OAuth.AccessToken.stringValue: Value.OAuth.AccessToken]

/// API's base URL.
private let BaseURL = "https://api.github.com"

public class RequestController {
  
  /// Returns the shared RequestController.
  public static let sharedInstance = RequestController()
}

// MARK: - Requestable
extension RequestController: Requestable {
  
  /// Lists all issues across all the authenticated user’s visible repositories including owned repositories, member repositories, and organization repositories
  public func requestIssues(parameterOptions: IssueParameterOptions = IssueParameterOptions()) {
    let parameters = Parse.parseIssueParameterOptions(parameterOptions) + Authorization
    
    Alamofire.request(.GET, "\(BaseURL)\(issues)", parameters: parameters)
      .responseJSON { request, response, json, error in
        print("request: \(request)")
        print("response: \(response)")
        print("JSON: \(json)")
        
        if let json = Parse.optionalJSONFromAnyObject(anyObject: json) {
          Parse.parseIssues(json)
        }
        
        print("Error: \(error)")
    }
  }
  
  /// Lists all issues across owned and member repositories for the authenticated user
  public func requestUserIssues(parameterOptions: IssueParameterOptions = IssueParameterOptions()) {
    let parameters = Parse.parseIssueParameterOptions(parameterOptions) + Authorization
    
    Alamofire.request(.GET, "\(BaseURL)\(userIssues)", parameters: parameters)
      .responseJSON { request, response, json, error in
        print("request: \(request)")
        print("response: \(response)")
        
        if let json = Parse.optionalJSONFromAnyObject(anyObject: json) {
          Parse.parseIssues(json)
        }
        
        print("Error: \(error)")
    }
  }
}