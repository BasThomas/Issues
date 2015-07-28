//
//  IndexPath+Add.swift
//  Issues
//
//  Created by Bas Broek on 28/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

public enum Location {
  
  case Top
  case Bottom
}

public func newIndexPaths(now now: Int, add new: Int, location: Location = .Top) -> [NSIndexPath] {
  var indexPaths: [NSIndexPath] = []
  
  switch(location) {
  case .Top:
    for _ in 0..<new {
      indexPaths.append(NSIndexPath(forRow: 0, inSection: 0))
    }
  case .Bottom:
    for i in 0..<new {
      indexPaths.append(NSIndexPath(forRow: now + i, inSection: 0))
    }
  }
  
  return indexPaths
}