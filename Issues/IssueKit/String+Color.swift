//
//  String+Color.swift
//  Issues
//
//  Created by Bas on 06/07/2015.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension String {
  
  /// Creates a Color from the Hex-string.
  public var color: Color? {
    var red:   CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue:  CGFloat = 0.0
    var alpha: CGFloat = 1.0
    
    let hex: Hex
    
    if self.hasPrefix("#") {
      let index = advance(self.startIndex, 1)
      hex = self.substringFromIndex(index)
    } else {
      hex = self
    }
    
    let scanner = NSScanner(string: hex)
    var hexValue: CUnsignedLongLong = 0
    if scanner.scanHexLongLong(&hexValue) {
      switch (hex.characters.count) {
      case 3:
        red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
        green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
        blue  = CGFloat(hexValue & 0x00F)              / 15.0
      case 6:
        red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
        green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
        blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
      case 8:
        red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
        green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
        blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
        alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
      default:
        return nil
      }
      
      return Color(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    return nil
  }
}