//
//  NSHTTPURLResponse+ETag.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension NSHTTPURLResponse {
  
  /// The response's ETag.
  var eTag: String? {
    return self.allHeaderFields["ETag"] as? String
  }
  
  /// The response's ETagValue.
  var eTagValue: String {
    return self.eTag ?? ""
  }
}