//
//  Dictionary+Merge.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

func +<K,V>(left: [K: V], right: [K: V]) -> [K: V] {
  
  var dictionary: [K: V] = [:]
  
  for (k, v) in left {
    dictionary[k] = v
  }
  
  for (k, v) in right {
    dictionary[k] = v
  }
  
  return dictionary
}