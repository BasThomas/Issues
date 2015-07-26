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

  @IBOutlet weak var issueTitleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}