//
//  IssuesUITests.swift
//  IssuesUITests
//
//  Created by Bas Broek on 29/06/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation
import XCTest

class IssuesUITests: XCTestCase {
        
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
}