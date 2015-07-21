//
//  ParseController.swift
//  Issues
//
//  Created by Bas Broek on 11/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct ParseController {
  public static let sharedInstance = ParseController()
  
  public func parseIssues(json: [String: AnyObject]) -> [Issue] {
    print(json)
    
    return []
  }
  
  public func parseIssues(jsonString: String) -> [Issue] {
    if let json = self.parseJSON(jsonString) {
      if let json = json as? NSArray {
        let jsonDict = json[0]
        
        if let number = jsonDict["number"] as? Int,
          let title = jsonDict["title"] as? String,
          let body = jsonDict["body"] as? String,
          let state = jsonDict["state"] as? String {
          
          let enumState = State(rawValue: state)
          print("num: \(number), title: \(title), body: \(body). state: \(enumState)")
        }
        
      } else if let json = json as? NSDictionary {
        print("it's a dict: \(json)")
      }
    }
    
    return []
  }
}

extension ParseController {
  private func parseJSON(jsonString: String) -> AnyObject? {
    let data = (jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
    
    if let data = data {
      do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        
        return json
      } catch {
        print("error: \(error)")
      }
    }
    
    return nil
  }
}