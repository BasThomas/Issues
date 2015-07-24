//
//  MainViewController.swift
//  Issues
//
//  Created by Bas Broek on 22/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit
import IssueKit

class MainViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    ParseController.sharedInstance.requestIssues()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}