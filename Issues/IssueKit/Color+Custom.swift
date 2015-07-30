//
//  Color+Custom.swift
//  Issues
//
//  Created by Bas Broek on 29/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension Color {
  
  /// Returns a color object whose RGB values are 0.42, 0.78, and 0.27 and whose alpha value is 0.4.
  ///
  /// The `Color` object.
  public class func gitHubGreenColor() -> Color {
    return Color(red: 0.42, green: 0.78, blue: 0.27, alpha: 1.0)
  }
  
  /// Returns a color object whose RGB values are 0.74, 0.17, and 0.0 and whose alpha value is 0.4.
  ///
  /// The `Color` object.
  public class func gitHubRedColor() -> Color {
    return Color(red: 0.74, green: 0.17, blue: 0.0, alpha: 1.0)
  }
}