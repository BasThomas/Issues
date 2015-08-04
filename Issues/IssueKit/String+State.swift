//
//  String+State.swift
//  Issues
//
//  Created by Bas Broek on 03/08/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public func generateState(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  var randomString = ""
  
  for _ in 0..<length {
    let rand = Int(arc4random_uniform(UInt32(letters.characters.count)))
    let index = advance(letters.startIndex, rand)
    
    randomString.append(letters[index])
  }
  
  return randomString
}