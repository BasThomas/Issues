//
//  ETaggable.swift
//  Issues
//
//  Created by Bas Broek on 27/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

protocol ETaggable {
  
  var requestIssuesETag: String? { get set }
  var requestUserIssuesETag: String? { get set }
  
  var requestUserRepositoriesETag: String? { get set }
  var requestRepositoryETag: String? { get set }
  
  var requestLabelsForRepositoryETag: String? { get set }
  var requestAssigneesForRepositoryETag: String? { get set }
  var requestMilestonesForRepositoryETag: String? { get set }
}