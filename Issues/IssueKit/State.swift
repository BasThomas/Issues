//
//  State.swift
//  Issues
//
//  Created by Bas on 06/07/2015.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public enum State: String, StringRawRepresentable, LowercaseInitializable {
  
  case Open
  case Closed
  
  /// All values of the enum.
  public static let allValues = [Open, Closed]
}