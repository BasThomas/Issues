//
//  ParseController.swift
//  Issues
//
//  Created by Bas Broek on 11/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation
import SwiftyJSON

private let Request = RequestController.sharedInstance

public class ParseController {
  
  private var parsedRepositories: [Repository] = []
  private var parsedLabels: Set<Label> = []
  private var parsedMilestones: [Milestone] = []
  private var parsedUsers: [User] = []
  
  /// Returns the shared ParseController.
  public static let sharedInstance = ParseController()
  
  /// The delegate of the ParseController.
  var delegate: ParseDelegate?
}

// MARK: - Parseable
// MARK: - Issues
extension ParseController: Parseable {
  
  /// Parses all issues across all the authenticated user’s visible repositories
  /// including owned repositories, member repositories, and organization repositories
  ///
  /// - Parameter json: json to parse.
  ///
  /// - Returns: `[Issue]` array of issues, empty if none are found.
  func parseIssues(json: JSON) -> [Issue] {
    var issues: [Issue] = []
    
    for issue in json {
      let issue = issue.1
      
      // Skips any pull requests.
      guard issue["pull_request"].dictionary == nil else { continue }
      
      if let id = issue["id"].int,
       let repository = issue["repository"].dictionary,
       let number = issue["number"].int,
       let title = issue["title"].string,
       let body = issue["body"].string,
       let _state = issue["state"].string,
       let state = State(rawValue: _state),
       let locked = issue["locked"].bool,
       let commentsURL = issue["comments_url"].string,
       let creationDate = issue["created_at"].string?.date {
        
        do {
          var assignee: Assignee?
          
          if let _assignee = issue["assignee"].dictionary {
            assignee = self.parseUser(_assignee)
          }
          
          var labels: Set<Label> = []
          
          if let _labels = issue["labels"].array {
            self.parseLabels(_labels).map { labels.insert($0) }
          }
          
          var milestone: GitHubMilestone?
          
          if let _milestone = issue["milestone"].dictionary {
            milestone = try self.parseMilestone(_milestone) as? GitHubMilestone
          }
          
          let closingDate = issue["closed_at"].string?.date
          
          let ghIssue = GitHubIssue(id: id, number: number, title: title, body: body, state: state, locked: locked, commentsURL: commentsURL, assignee: assignee, labels: labels, milestone: milestone, creationDate: creationDate, closingDate: closingDate)
          
          issues.append(ghIssue)
          
          try self.getRepositoryForIssue(ghIssue, json: repository)
        } catch (ParseError.InvalidParse) {
          print("Invalid parsing.")
        } catch {
          print("Something happened. Please Swift team, let me be able to tell which Errors I want to throw. :-(")
        }
      }
    }
    
    self.delegate?.parsedIssues(issues)
    return issues
  }
}

// MARK: Repositories
extension ParseController {
  
  func getRepositoryForIssue(issue: Issue, json: [String: JSON]) throws {
    if let fullName = json["full_name"]?.string {
      Request.requestRepositoryForIssue(issue, fullName: fullName)
    }
    
    throw ParseError.InvalidParse
  }
  
  func parseRepositoryForIssue(var issue: Issue, json: JSON) {
    if let id = json["id"].int,
     let _owner = json["owner"].dictionary,
     let name = json["name"].string,
     let fullName = json["full_name"].string,
     let isFork = json["fork"].bool,
     let isPrivate = json["private"].bool,
     let canPush = json["permissions", "push"].bool {
      let alreadyAddedRepository = self.parsedRepositories.filter { $0.id == id }.first
    
      if let repository = alreadyAddedRepository {
        issue.repository = repository
        
        self.delegate?.refresh(issue)
        
        return
      }
    
      if let owner = self.parseUser(_owner) {
        let newRepository = GitHubRepository(id: id, owner: owner, name: name, fullName: fullName, isFork: isFork, isPrivate: isPrivate, canPush: canPush)
        self.parsedRepositories.append(newRepository)
        
        Request.requestLabelsForRepository(newRepository)
        Request.requestAssigneesForRepository(newRepository)
        Request.requestMilestonesForRepository(newRepository)
        
        issue.repository = newRepository
        self.delegate?.refresh(issue)
      }
    }
  }
  
  /// Parses all repositories of every public repository.
  ///
  /// - Parameter json: json to parse.
  ///
  /// - Returns: `[Repository]` array of repositories, empty if none are found.
  func parseRepositories(json: JSON) -> [Repository] {
    var repositories: [Repository] = []
    
    for repository in json {
      let repository = repository.1
      
      if let id = repository["id"].int,
       let _owner = repository["owner"].dictionary,
       let name = repository["name"].string,
       let fullName = repository["full_name"].string,
       let isFork = repository["fork"].bool,
       let isPrivate = repository["private"].bool,
       let canPush = repository["permissions", "push"].bool {
        let alreadyAddedRepository = self.parsedRepositories.filter { $0.id == id }.first
        
        if let repository = alreadyAddedRepository {
          repositories.append(repository)
          
          self.delegate?.refresh(repository)
          
          continue
        }
        
        if let owner = self.parseUser(_owner) {
          let ghRepository = GitHubRepository(id: id, owner: owner, name: name, fullName: fullName, isFork: isFork, isPrivate: isPrivate, canPush: canPush)
          repositories.append(ghRepository)
          
          Request.requestLabelsForRepository(ghRepository)
          Request.requestAssigneesForRepository(ghRepository)
          Request.requestMilestonesForRepository(ghRepository)
          
          self.delegate?.refresh(ghRepository)
        }
      }
    }
    
    self.delegate?.parsedRepositores(repositories)
    return repositories
  }
}

// MARK: Labels
extension ParseController {
  
  func parseLabels(json: [JSON]) -> [Label] {
    var labels: [Label] = []
    
    for label in json {
      if let name = label["name"].string,
       let hex = label["color"].string {
        
        let alreadyAddedLabel = self.parsedLabels.filter { $0.name == name && $0.hex == hex }.first
        
        if let label = alreadyAddedLabel {
          labels.append(label)
          continue
        }
        
        let newLabel = Label(name: name, hex: hex)
        self.parsedLabels.insert(newLabel)
        labels.append(newLabel)
      }
    }
    return labels
  }
  
  func parseLabels(json: JSON, var forRepository repository: Repository? = nil) -> [Label] {
    var labels: [Label] = []
    
    for label in json {
      let label = label.1
      
      if let name = label["name"].string,
       let hex = label["color"].string {
        
        let alreadyAddedLabel = self.parsedLabels.filter { $0.name == name && $0.hex == hex }.first
        
        if let label = alreadyAddedLabel {
          labels.append(label)
          continue
        }
        
        let newLabel = Label(name: name, hex: hex)
        self.parsedLabels.insert(newLabel)
        labels.append(newLabel)
      }
    }
    
    repository?.labels = labels
    
    if let repository = repository {
      self.delegate?.refresh(repository)
    }
    return labels
  }
}

// MARK: Assignee
extension ParseController {
  
  func parseUser(json: [String: JSON]) -> User? {
    if let id = json["id"]?.int,
     let avatarURL = json["avatar_url"]?.string,
     let name = json["login"]?.string {
      
      let alreadyAddedUser = self.parsedUsers.filter { $0.id == id }.first
      
      if let user = alreadyAddedUser {
        return user
      }
      
      let newUser = User(id: id, avatarURL: avatarURL, name: name)
      self.parsedUsers.append(newUser)
      
      return newUser
    }
    
    return nil
  }
  
  func parseAssignees(json: JSON, var forRepository repository: Repository? = nil) -> [Assignee] {
    var assignees: [Assignee] = []
    
    for assignee in json {
      let assignee = assignee.1
      
      if let id = assignee["id"].int,
        let avatarURL = assignee["avatar_url"].string,
        let name = assignee["login"].string {
          
          let alreadyAddedAssignee = self.parsedUsers.filter { $0.id == id }.first
          
          if let assignee = alreadyAddedAssignee {
            assignees.append(assignee)
            continue
          }
          
          let newAssignee = Assignee(id: id, avatarURL: avatarURL, name: name)
          self.parsedUsers.append(newAssignee)
          
          assignees.append(newAssignee)
      }
    }
    
    repository?.assignees = assignees
    
    if let repository = repository {
      self.delegate?.refresh(repository)
    }
    return assignees
  }
}

// MARK: Milestones
extension ParseController {
  
  func parseMilestone(json: [String : JSON]) throws -> Milestone {
    if let id = json["id"]?.int,
      let title = json["title"]?.string,
      let _state = json["state"]?.string,
      let state = State(rawValue: _state) {
        
        let alreadyAddedMilestone = self.parsedMilestones.filter { $0.id == id }.first
        
        if let milestone = alreadyAddedMilestone {
          return milestone
        }
        
        let description = json["description"]?.string
        let dueDate = json["due_on"]?.string?.date
        
        let newMilestone = GitHubMilestone(id: id, title: title, state: state, description: description, dueDate: dueDate)
        self.parsedMilestones.append(newMilestone)
        
        return newMilestone
    }
    
    throw ParseError.InvalidParse
  }
  
  func parseMilestones(json: JSON, var forRepository repository: Repository? = nil) -> [Milestone] {
    var milestones: [Milestone] = []
    
    for milestone in json {
      let milestone = milestone.1
      
      if let id = milestone["id"].int,
        let title = milestone["title"].string,
        let _state = milestone["state"].string,
        let state = State(rawValue: _state) {
          
          let alreadyAddedMilestone = self.parsedMilestones.filter { $0.id == id }.first
          
          if let milestone = alreadyAddedMilestone {
            milestones.append(milestone)
            continue
          }
          
          let description = milestone["description"].string
          let dueDate = milestone["due_on"].string?.date
          
          let newMilestone = GitHubMilestone(id: id, title: title, state: state, description: description, dueDate: dueDate)
          self.parsedMilestones.append(newMilestone)
          
          milestones.append(newMilestone)
      }
    }
    
    repository?.milestones = milestones
    
    if let repository = repository {
      print("delegating repo w/ milestones: \(repository.milestones)")
      self.delegate?.refresh(repository)
    }
    return milestones
  }
}

extension ParseController {
  
  /// Parses AnyObject? to JSON?
  ///
  /// - Parameter anyObject: data to parse.
  ///
  /// - Returns `JSON?`
  func optionalJSONFromAnyObject(anyObject data: AnyObject?) -> JSON? {
    guard let data = data else { return nil }
    
    return JSON(data)
  }
  
  /// Parses AnyObject? to JSON.
  ///
  /// - Parameter anyObject: data to parse.
  ///
  /// - Throws: `InvalidObject` when failing to parse the data.
  ///
  /// - Returns `JSON`
  func jsonFromAnyObject(anyObject data: AnyObject?) throws -> JSON {
    guard let data = data else { throw JSONError.InvalidObject }
    
    return JSON(data)
  }
  
  func jsonFromData(data: NSData) -> JSON {
    return JSON(data: data)
  }
}