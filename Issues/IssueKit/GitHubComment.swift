//
//  GitHubComment.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public struct GitHubComment: Comment {
  
  /// Body of the comment.
  public var body: String
  
  public init(body: String) {
    self.body = body
  }
}

// MARK: - Hashable
extension GitHubComment: Hashable {
  
  /// The hash value.
  public var hashValue: Int {
    return self.body.hashValue
  }
}

// MARK: - Equatable
extension GitHubComment: Equatable { }

public func ==(lhs: GitHubComment, rhs: GitHubComment) -> Bool {
  return lhs.body == rhs.body
}