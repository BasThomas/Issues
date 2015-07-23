//
//  Array+RemoveTests.swift
//  Issues
//
//  Created by Bas Broek on 24/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import XCTest
import IssueKit

class Array_RemoveTests: XCTestCase {
  
  let foo = "foo"
  let bar = "bar"
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testRemoveFromEmptyArray() {
    var emptyArray: [String] = []
    
    XCTAssertFalse(emptyArray.removeObject(foo), "As the array \(emptyArray) is empty, \(foo) couldn't be removed.")
  }
  
  func testRemoveInvalidObjectFromArray() {
    var fooArray = [foo]
    
    XCTAssertFalse(fooArray.removeObject(bar), "As the array \(fooArray) doesn't contain \(bar), \(bar) couldn't be removed.")
  }
  
  func testRemoveValidObjectFromArray() {
    var fooArray = [foo]
    
    XCTAssertTrue(fooArray.removeObject(foo), "As the array \(fooArray) contains \(foo), \(foo) should be removeable.")
  }
}