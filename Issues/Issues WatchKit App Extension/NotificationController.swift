//
//  NotificationController.swift
//  Issues WatchKit App Extension
//
//  Created by Bas Broek on 29/06/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import WatchKit

class NotificationController: WKUserNotificationInterfaceController {

  override init() {
    super.init()
  }

  override func willActivate() {
    super.willActivate()
  }

  override func didDeactivate() {
    super.didDeactivate()
  }

  override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
    completionHandler(.Custom)
  }

  override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
    completionHandler(.Custom)
  }
}