//
//  IndexPath+Add.swift
//  Issues
//
//  Created by Bas Broek on 28/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

public func newIndexPaths(now now: Int, add new: Int) -> [NSIndexPath] {
  var indexPaths: [NSIndexPath] = []
  
  for i in 0..<new {
    indexPaths.append(NSIndexPath(forRow: now + i, inSection: 0))
  }
  
  return indexPaths
}