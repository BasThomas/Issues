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

/// API's base URL.
private let BaseURL = "https://api.github.com"

private struct Request {
  
  private static let RequestIssues = "\(BaseURL)\(issues)"
  private static let RequestUserIssues = "\(BaseURL)\(userIssues)"
}

public class RequestController: ETaggable {
  
  /// The delegate of the RequestController.
  public var delegate: RequestDelegate?
  
  /// RequestIssues' ETag.
  var requestIssuesETag: String?
  
  /// RequestUserIssues' ETag.
  var requestUserIssuesETag: String?
  
  /// Returns the shared RequestController.
  public static let sharedInstance = RequestController()
  
  private init() {
    Parse.delegate = self
  }
}

// MARK: - ParseDelegate
extension RequestController: ParseDelegate {
  
  public func parsedIssues(issues: [Issue]) {
    self.delegate?.refresh(issues)
  }
}

// MARK: - Requestable
extension RequestController: Requestable {
  
  /// Lists all issues across all the authenticated user’s visible repositories including owned repositories, member repositories, and organization repositories
  public func requestIssues(parameterOptions: IssueParameterOptions = IssueParameterOptions()) {
    let parameters = Parse.parseIssueParameterOptions(parameterOptions)
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestIssuesETag))
    
    Alamofire.request(.GET, Request.RequestIssues, parameters: parameters, headers: headers)
      .responseJSON { request, response, json, error in
        print("request: \(request)")
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        
        self.requestIssuesETag = response?.eTag
        
        print("JSON: \(json)")
        
        if let json = Parse.optionalJSONFromAnyObject(anyObject: json) {
          Parse.parseIssues(json)
        }
        
        print("Error: \(error)")
        
        self.delegate?.endRefreshing()
    }
  }
  
  /// Lists all issues across owned and member repositories for the authenticated user
  public func requestUserIssues(parameterOptions: IssueParameterOptions = IssueParameterOptions()) {
    let parameters = Parse.parseIssueParameterOptions(parameterOptions)
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestUserIssuesETag))
    
    Alamofire.request(.GET, Request.RequestUserIssues, parameters: parameters, headers: headers)
      .responseJSON { request, response, json, error in
        print("request: \(request)")
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        
        self.requestUserIssuesETag = response?.eTag
        
        print("JSON: \(json)")
        
        if let json = Parse.optionalJSONFromAnyObject(anyObject: json) {
          Parse.parseIssues(json)
        }
        
        print("Error: \(error)")
        
        self.delegate?.endRefreshing()
    }
  }
}