//
//  ParseError.swift
//  Issues
//
//  Created by Bas Broek on 30/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public enum ParseError: ErrorType {
  
  case InvalidParse
  case Unknown(message: String)
}