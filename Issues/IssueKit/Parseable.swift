//
//  Parseable.swift
//  Issues
//
//  Created by Bas Broek on 25/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Parseable: ParameterParseable, HeaderParseable {
  
  func parseIssues(json: JSON) -> [Issue]
}