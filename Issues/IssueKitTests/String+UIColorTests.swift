//
//  String+UIColorTests.swift
//  Issues
//
//  Created by Bas Broek on 23/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import XCTest
import IssueKit

private let InvalidHex = "The Hex was invalid."
private let InvalidColor = "The color was invalid."

class String_UIColorTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testThreeDigitHexWithoutHashtag() {
    let red = "F00"
    let green = "0F0"
    let blue = "00F"
    
    XCTAssertNotNil(red.color, InvalidHex)
    
    if let red = red.color {
      XCTAssertEqual(red, UIColor.redColor(), InvalidColor)
    }
    
    XCTAssertNotNil(green.color, InvalidHex)
    
    if let green = green.color {
      XCTAssertEqual(green, UIColor.greenColor(), InvalidColor)
    }
    
    XCTAssertNotNil(blue.color, InvalidHex)
    
    if let blue = blue.color {
      XCTAssertEqual(blue, UIColor.blueColor(), InvalidColor)
    }
  }
  
  func testThreeDigitHexWithHashtag() {
    let yellow = "#FF0"
    let cyan = "#0FF"
    let magenta = "#F0F"
    
    XCTAssertNotNil(yellow.color, InvalidHex)
    
    if let yellow = yellow.color {
      XCTAssertEqual(yellow, UIColor.yellowColor(), InvalidColor)
    }
    
    XCTAssertNotNil(cyan.color, InvalidHex)
    
    if let cyan = cyan.color {
      XCTAssertEqual(cyan, UIColor.cyanColor(), InvalidColor)
    }
    
    XCTAssertNotNil(magenta.color, InvalidHex)
    
    if let magenta = magenta.color {
      XCTAssertEqual(magenta, UIColor.magentaColor(), InvalidColor)
    }
  }
  
  func testSixDigitHexWithoutHashtag() {
    let red = "FF0000"
    let green = "00FF00"
    let blue = "0000FF"
    
    XCTAssertNotNil(red.color, InvalidHex)
    
    if let red = red.color {
      XCTAssertEqual(red, UIColor.redColor(), InvalidColor)
    }
    
    XCTAssertNotNil(green.color, InvalidHex)
    
    if let green = green.color {
      XCTAssertEqual(green, UIColor.greenColor(), InvalidColor)
    }
    
    XCTAssertNotNil(blue.color, InvalidHex)
    
    if let blue = blue.color {
      XCTAssertEqual(blue, UIColor.blueColor(), InvalidColor)
    }
  }
  
  func testSixDigitHexWithHashtag() {
    let yellow = "#FFFF00"
    let cyan = "#00FFFF"
    let magenta = "#FF00FF"
    
    XCTAssertNotNil(yellow.color, InvalidHex)
    
    if let yellow = yellow.color {
      XCTAssertEqual(yellow, UIColor.yellowColor(), InvalidColor)
    }
    
    XCTAssertNotNil(cyan.color, InvalidHex)
    
    if let cyan = cyan.color {
      XCTAssertEqual(cyan, UIColor.cyanColor(), InvalidColor)
    }
    
    XCTAssertNotNil(magenta.color, InvalidHex)
    
    if let magenta = magenta.color {
      XCTAssertEqual(magenta, UIColor.magentaColor(), InvalidColor)
    }
  }
  
  func testEightDigitHexWithoutHashtag() {
    let transparentRed = "FF000066"
    let transparentGreen = "00FF0066"
    let transparentBlue = "0000FF66"
    
    XCTAssertNotNil(transparentRed.color, InvalidHex)
    
    if let transparentRed = transparentRed.color {
      XCTAssertEqual(transparentRed, UIColor.transparentRedColor(), InvalidColor)
    }
    
    XCTAssertNotNil(transparentGreen.color, InvalidHex)
    
    if let transparentGreen = transparentGreen.color {
      XCTAssertEqual(transparentGreen, UIColor.transparentGreenColor(), InvalidColor)
    }
    
    XCTAssertNotNil(transparentBlue.color, InvalidHex)
    
    if let transparentBlue = transparentBlue.color {
      XCTAssertEqual(transparentBlue, UIColor.transparentBlueColor(), InvalidColor)
    }
  }
  
  func testEightDigitHexWithHashtag() {
    let transparentYellow = "#FFFF0066"
    let transparentCyan = "#00FFFF66"
    let transparentMagenta = "#FF00FF66"
    
    XCTAssertNotNil(transparentYellow.color, InvalidHex)
    
    if let transparentYellow = transparentYellow.color {
      XCTAssertEqual(transparentYellow, UIColor.transparentYellowColor(), InvalidColor)
    }
    
    XCTAssertNotNil(transparentCyan.color, InvalidHex)
    
    if let transparentCyan = transparentCyan.color {
      XCTAssertEqual(transparentCyan, UIColor.transparentCyanColor(), InvalidColor)
    }
    
    XCTAssertNotNil(transparentMagenta.color, InvalidHex)
    
    if let transparentMagenta = transparentMagenta.color {
      XCTAssertEqual(transparentMagenta, UIColor.transparentMagentaColor(), InvalidColor)
    }
  }
  
  func testWithGibberish() {
    let hashtagGibberish = "#gibberish"
    let gibberish = "gibberish"
    
    XCTAssertNil(hashtagGibberish.color, "\(hashtagGibberish) is not a color.")
    XCTAssertNil(gibberish.color, "\(gibberish) is not a color.")
  }
  
  func testInvalidHexLength() {
    let tooLongHex = "FF00FF00FF00FF"
    let tooShortHex = "FF"
    
    XCTAssertNil(tooLongHex.color, "Hex \(tooLongHex) is too long.")
    XCTAssertNil(tooShortHex.color, "Hex \(tooShortHex) is too short.")
  }
}

extension UIColor {
  
  /// Returns a color object whose RGB values are 1.0, 0.0, and 0.0 and whose alpha value is 0.4.
  ///
  /// The `UIColor` object.
  class func transparentRedColor() -> UIColor {
    return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.4)
  }
  
  /// Returns a color object whose RGB values are 0.0, 1.0, and 0.0 and whose alpha value is 0.4.
  ///
  /// The `UIColor` object.
  class func transparentGreenColor() -> UIColor {
    return UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.4)
  }
  
  /// Returns a color object whose RGB values are 0.0, 0.0, and 1.0 and whose alpha value is 0.4.
  ///
  /// The `UIColor` object.
  class func transparentBlueColor() -> UIColor {
    return UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.4)
  }
  
  /// Returns a color object whose RGB values are 1.0, 1.0, and 0.0 and whose alpha value is 0.4.
  ///
  /// The `UIColor` object.
  class func transparentYellowColor() -> UIColor {
    return UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.4)
  }
  
  /// Returns a color object whose RGB values are 0.0, 1.0, and 1.0 and whose alpha value is 0.4.
  ///
  /// The `UIColor` object.
  class func transparentCyanColor() -> UIColor {
    return UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.4)
  }
  
  /// Returns a color object whose RGB values are 1.0, 0.0, and 1.0 and whose alpha value is 0.4.
  ///
  /// The `UIColor` object.
  class func transparentMagentaColor() -> UIColor {
    return UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.4)
  }
}