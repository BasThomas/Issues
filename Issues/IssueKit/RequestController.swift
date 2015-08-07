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
  
  private static func POSTIssue(repository: Repository) -> String {
    return "\(BaseURL)\(repos)/\(repository.fullName)\(issues)"
  }
  
  private static func GETRepository(fullName: String) -> String {
    return "\(BaseURL)\(repos)/\(fullName)"
  }
  
  private static func GETLabelsForRepository(repository: Repository) -> String {
    return "\(BaseURL)\(repos)/\(repository.fullName)\(labels)"
  }
  
  private static func GETAssigneesForRepository(repository: Repository) -> String {
    return "\(BaseURL)\(repos)/\(repository.fullName)\(assignees)"
  }
  
  private static func GETMilestonesForRepository(repository: Repository) -> String {
    return "\(BaseURL)\(repos)/\(repository.fullName)\(milestones)"
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
  
  /// RequestLabelsForRepository's ETag.
  var requestLabelsForRepositoryETag: String?
  
  /// RequestAssigneesForRepository's ETag.
  var requestAssigneesForRepositoryETag: String?
  
  /// RequestMilestonesForRepository's ETag.
  var requestMilestonesForRepositoryETag: String?
  
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
  
  func refresh(issue: Issue) {
    self.delegate?.refresh(issue)
  }
  
  func refresh(repository: Repository) {
    self.delegate?.refresh(repository)
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
      .responseJSON { request, response, json in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        self.requestIssuesETag = response?.eTag
        guard json.isSuccess else { print("request: \(request)"); print("JSON: \(json)"); self.delegate?.endRefreshing(); return }
        guard let value = json.value else { self.delegate?.endRefreshing(); return }
        guard let json = Parse.optionalJSONFromAnyObject(anyObject: value) else { self.delegate?.endRefreshing(); return }
        Parse.parseIssues(json)
        
        self.delegate?.endRefreshing()
    }
  }
  
  /// Lists all issues across owned and member repositories for the authenticated user.
  public func requestUserIssues(parameterOptions: IssueParameterOptions = IssueParameterOptions()) {
    let parameters = Parse.parseParameterOptions(parameterOptions)
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestUserIssuesETag))
    
    Alamofire.request(.GET, Request.GETUserIssues, parameters: parameters, headers: headers)
      .responseJSON { request, response, json in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        self.requestUserIssuesETag = response?.eTag
        guard json.isSuccess else { print("request: \(request)"); print("JSON: \(json)"); self.delegate?.endRefreshing(); return }
        guard let value = json.value else { self.delegate?.endRefreshing(); return }
        guard let json = Parse.optionalJSONFromAnyObject(anyObject: value) else { self.delegate?.endRefreshing(); return }
        Parse.parseIssues(json)
        
        self.delegate?.endRefreshing()
    }
  }
}

extension RequestController {
  
  /// Creates an issue for the references repository.
  public func createIssue(issue: Parameters, repository: Repository) {
    let parameters = issue
    let headers = Parse.parseHeaders()
    
    Alamofire.request(.POST, Request.POSTIssue(repository), parameters: parameters, encoding: .JSON, headers: headers)
      .responseJSON { request, response, json in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        guard json.isSuccess else { print("request: \(request)"); print("JSON: \(json)"); self.delegate?.endRefreshing(); return }
        guard let value = json.value else { self.delegate?.endRefreshing(); return }
        guard let json = Parse.optionalJSONFromAnyObject(anyObject: value) else { self.delegate?.endRefreshing(); return }
//        Parse.parseIssues(json)
        
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
      .responseJSON { request, response, json in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        self.requestUserRepositoriesETag = response?.eTag
        guard json.isSuccess else { print("request: \(request)"); print("JSON: \(json)"); self.delegate?.endRefreshing(); return }
        guard let value = json.value else { self.delegate?.endRefreshing(); return }
        guard let json = Parse.optionalJSONFromAnyObject(anyObject: value) else { self.delegate?.endRefreshing(); return }
        Parse.parseRepositories(json)
        
        self.delegate?.endRefreshing()
    }
  }
  
  public func requestRepositoryForIssue(issue: Issue, fullName: String) {
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestRepositoryETag))
    
    Alamofire.request(.GET, Request.GETRepository(fullName), headers: headers)
      .responseJSON { request, response, json in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        self.requestRepositoryETag = response?.eTag
        guard json.isSuccess else { print("request: \(request)"); print("JSON: \(json)"); self.delegate?.endRefreshing(); return }
        guard let value = json.value else { self.delegate?.endRefreshing(); return }
        guard let json = Parse.optionalJSONFromAnyObject(anyObject: value) else { self.delegate?.endRefreshing(); return }
        Parse.parseRepositoryForIssue(issue, json: json)
        
        self.delegate?.endRefreshing()
    }
  }
}

// MARK: Labels
extension RequestController {
  
  func requestLabelsForRepository(repository: Repository) {
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestLabelsForRepositoryETag))
    
    Alamofire.request(.GET, Request.GETLabelsForRepository(repository), headers: headers)
    .responseJSON { request, response, json in
      print("response: \(response)")
      
      guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
      self.requestLabelsForRepositoryETag = response?.eTag
      guard json.isSuccess else { print("request: \(request)"); print("JSON: \(json)"); self.delegate?.endRefreshing(); return }
      guard let value = json.value else { self.delegate?.endRefreshing(); return }
      guard let json = Parse.optionalJSONFromAnyObject(anyObject: value) else { self.delegate?.endRefreshing(); return }
      Parse.parseLabels(json, forRepository: repository)
      
      self.delegate?.endRefreshing()
    }
  }
}

// MARK: Assignees
extension RequestController {
  
  func requestAssigneesForRepository(repository: Repository) {
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestAssigneesForRepositoryETag))
    
    Alamofire.request(.GET, Request.GETAssigneesForRepository(repository), headers: headers)
      .responseJSON { request, response, json in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        self.requestAssigneesForRepositoryETag = response?.eTag
        guard json.isSuccess else { print("request: \(request)"); print("JSON: \(json)"); self.delegate?.endRefreshing(); return }
        guard let value = json.value else { self.delegate?.endRefreshing(); return }
        guard let json = Parse.optionalJSONFromAnyObject(anyObject: value) else { self.delegate?.endRefreshing(); return }
        Parse.parseAssignees(json, forRepository: repository)
        
        self.delegate?.endRefreshing()
      }
  }
}

// MARK: Milestones
extension RequestController {
  
  func requestMilestonesForRepository(repository: Repository) {
    let headers = Parse.parseHeaders(HeaderOptions(eTag: self.requestMilestonesForRepositoryETag))
    
    Alamofire.request(.GET, Request.GETMilestonesForRepository(repository), headers: headers)
      .responseJSON { request, response, json in
        print("response: \(response)")
        
        guard response?.statusCode != StatusCode.NotModified.intValue else { self.delegate?.endRefreshing(); return }
        self.requestMilestonesForRepositoryETag = response?.eTag
        guard json.isSuccess else { print("request: \(request)"); print("JSON: \(json)"); self.delegate?.endRefreshing(); return }
        guard let value = json.value else { self.delegate?.endRefreshing(); return }
        guard let json = Parse.optionalJSONFromAnyObject(anyObject: value) else { self.delegate?.endRefreshing(); return }
        Parse.parseMilestones(json, forRepository: repository)
        
        self.delegate?.endRefreshing()
    }
  }
}