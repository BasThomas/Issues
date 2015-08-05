//
//  RepositoryTableViewCell.swift
//  Issues
//
//  Created by Bas Broek on 28/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit

class RepositoryTableViewCell: UITableViewCell {
  
  var repository: Repository!
  
  @IBOutlet weak var repositoryImageView: UIImageView!
  @IBOutlet weak var repositoryNameLabel: UILabel!
  @IBOutlet weak var repositoryIsForkImageView: UIImageView!
  @IBOutlet weak var repositoryIsPrivateImageView: UIImageView!
}

extension RepositoryTableViewCell {
  
  /// Resets the cell.
  /// It seems like this is needed. Images get cached in a weird way or so. Not sure. ¯\_(ツ)_/¯
  func reset() {
    let PublicRepository = "public_repository"
    
    self.repositoryIsForkImageView.hidden = true
    
    if let publicRepository = UIImage(named: PublicRepository) {
      self.repositoryIsPrivateImageView.image = publicRepository
    }
  }
}