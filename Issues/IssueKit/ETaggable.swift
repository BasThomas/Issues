//
//  ETaggable.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public protocol ETaggable {
  
  var eTag: String { get set }
}