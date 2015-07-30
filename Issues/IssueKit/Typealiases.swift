//
//  Typealiases.swift
//  Issues
//
//  Created by Bas Broek on 30/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

#if os(iOS)
  import UIKit
  public typealias Color = UIColor
  #else
  import AppKit
  public typealias Color = NSColor
#endif

public typealias ETag = String
public typealias Hex = String

public typealias Parameters = [String: AnyObject]
public typealias Headers = [String: String]

public typealias Assignee = User