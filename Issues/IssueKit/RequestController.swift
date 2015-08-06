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
  
  private static let GETIssues = "\(BaseURL)\(issues)"
  private static let GETUserIssues = "\(BaseURL)\(user)\(issues)"
  
  private static let GETUserRepositories = "\(BaseURL)\(user)\(repos)"
  
  private static func POSTissue(repository: Repository) -> String {
    return "\(BaseURL)\(repos)/\(repository.fullName)\(issues)"
  }
  
  private static func GETRepository(fullName: String) -> String {
    return "\(BaseURL)\(repos)/\(fullName)"
  }
}

public class RequestController: ETaggable {
  
  /// The delegate of the RequestController.
  public var delegate: RequestDelegate?
  
  /// RequestIssues' ETag.
  var requestIssuesETag: String?
  
  /// RequestUserIssues' ETag.
  var requestUserIssuesETag: String?
  
  /// RequestRepositories' ETag.
  var requestUserRepositoriesETag: String?
  
  /// RequestRepository's ETag.
  var requestRepositoryETag: String?
  
  /// Returns the shared RequestController.
  public static let sharedInstance = RequestController()
  
  private init() {
    Parse.delegate = self
  }
}

// MARK: - ParseDelegate
extension RequestController: ParseDelegate {
  
  func parsedIssues(issues: [Issue]) {
    self.delegate?.refresh(issues)
  }
  
  func parsedRepositores(repositories: [Repository]) {
    self.delegate?.refresh(repositories)
  }
  
  func parsedLabelsForIssue(issue: Issue, labels: Set<Label>) {
    self.delegate?.refresh(issue, labels: labels)
  }
  
  func refreshIssue(issue: Issue) {
    self.delegate?.refresh(issue)
  }
}

// MARK: - Requestable
// MARK: Issues
extension RequestController: Requestable {
  
  /// Lists all issues across all the authenticated user’s visible repositories including owned repositories, member repositories, and organization repositories.
  public func requestIssues(parameterOptions: IssueParameterOptions = IssueParameterOptions()) {
    let parameters = Parse.parseParameterOptions(parameterOptions)
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestIssuesETag))
    
    Alamofire.request(.GET, Request.GETIssues, parameters: parameters, headers: headers)
      .responseJSON { request, response, json, error in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        
        self.requestIssuesETag = response?.eTag
        
        if let error = error {
          print("request: \(request)")
          print("JSON: \(json)")
          print("Error: \(error)")
        }
        
        if let json = Parse.optionalJSONFromAnyObject(anyObject: json) {
          Parse.parseIssues(json)
        }
        
        self.delegate?.endRefreshing()
    }
  }
  
  /// Lists all issues across owned and member repositories for the authenticated user.
  public func requestUserIssues(parameterOptions: IssueParameterOptions = IssueParameterOptions()) {
    let parameters = Parse.parseParameterOptions(parameterOptions)
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestUserIssuesETag))
    
    Alamofire.request(.GET, Request.GETUserIssues, parameters: parameters, headers: headers)
      .responseJSON { request, response, json, error in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        
        self.requestUserIssuesETag = response?.eTag
        
        if let error = error {
          print("request: \(request)")
          print("JSON: \(json)")
          print("Error: \(error)")
        }
        
        if let json = Parse.optionalJSONFromAnyObject(anyObject: json) {
          Parse.parseIssues(json)
        }
        
        self.delegate?.endRefreshing()
    }
  }
}

extension RequestController {
  
  /// Creates an issue for the references repository.
  public func createIssue(issue: Parameters, repository: Repository) {
    let parameters = issue
    let headers = Parse.parseHeaders()
    
    Alamofire.request(.POST, Request.POSTissue(repository), parameters: parameters, encoding: .JSON, headers: headers)
      .responseJSON { request, response, json, error in
        print("response: \(response)")
        
        if let error = error {
          print("request: \(request)")
          print("JSON: \(json)")
          print("Error: \(error)")
        }
        
        if let json = Parse.optionalJSONFromAnyObject(anyObject: json) {
//          Parse.parseIssues(json)
        }
        
        self.delegate?.endRefreshing()
    }
  }
}

// MARK: Repositories
extension RequestController {
  
  /// Lists repositories that are accessible to the authenticated user.
  public func requestUserRepositories(parameterOptions: RepositoryParameterOptions = RepositoryParameterOptions()) {
    let parameters = Parse.parseParameterOptions(parameterOptions)
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestUserRepositoriesETag))
    
    Alamofire.request(.GET, Request.GETUserRepositories, parameters: parameters, headers: headers)
      .responseJSON { request, response, json, error in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        
        self.requestUserRepositoriesETag = response?.eTag
        
        if let error = error {
          print("request: \(request)")
          print("JSON: \(json)")
          print("Error: \(error)")
        }
        
        if let json = Parse.optionalJSONFromAnyObject(anyObject: json) {
          Parse.parseRepositories(json)
        }
        
        self.delegate?.endRefreshing()
    }
  }
  
  public func requestRepositoryForIssue(issue: Issue, fullName: String) {
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestRepositoryETag))
    
    Alamofire.request(.GET, Request.GETRepository(fullName), headers: headers)
      .responseJSON(completionHandler: { request, response, json, error in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { return }
        
        self.requestRepositoryETag = response?.eTag
        
        if let error = error {
          print("request: \(request)")
          print("JSON: \(json)")
          print("Error: \(error)")
        }
        
        if let json = Parse.optionalJSONFromAnyObject(anyObject: json) {
          Parse.parseRepositoryForIssue(issue, json: json)
        }
      })
  }
}