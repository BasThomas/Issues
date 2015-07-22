//
//  Commentable.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol Commentable {
  
  func comment(body: String)
  func editComment(comment: Comment, body: String)
  func deleteComment(comment: Comment)
}