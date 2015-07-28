//
//  IssueTableViewCell.swift
//  Issues
//
//  Created by Bas Broek on 26/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit

class IssueTableViewCell: UITableViewCell {
  
  var issue: Issue!

  @IBOutlet weak var issueTitleLabel: UILabel!
  @IBOutlet weak var issueStateIconLabel: UILabel!
}