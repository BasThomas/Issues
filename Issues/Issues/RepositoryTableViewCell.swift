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
  
  @IBOutlet weak var nameLabel: UILabel!
}