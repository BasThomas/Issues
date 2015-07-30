//
//  CustomPrintable.swift
//  Issues
//
//  Created by Bas Broek on 30/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

protocol Printable: CustomStringConvertible {
  
  var file: String { get }
}

extension Printable {
  
  var file: String {
    let mi = Mirror(reflecting: self)
    let fileType = mi.subjectType
    
    return "\(fileType)"
  }
}