//
//  StatusCode.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

public enum StatusCode: Int, IntRawRepresentable {
  
  case OK = 200
  case NoContent = 204
  
  case NotModified = 304
  
  case BadRequest = 400
  case UnAuthorized = 401
  case Forbidden = 403
  case NotFound = 404
  case UnprocessableEntity = 422
  
  case InternalServerError = 500
  case NotImplemented = 501
  case BadGateway = 502
}