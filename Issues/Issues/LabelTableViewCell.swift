//
//  LabelTableViewCell.swift
//  Issues
//
//  Created by Bas Broek on 06/08/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit

class LabelTableViewCell: UITableViewCell {
  
  var repository: Repository!
  
  @IBOutlet weak var repositoryNameLabel: UILabel!
}