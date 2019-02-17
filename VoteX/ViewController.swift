//
//  ViewController.swift
//  VoteX
//
//  Created by Abhinav Kolli on 2/16/19.
//  Copyright © 2019 Abhinav Kolli. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let content = UNMutableNotificationContent()
        content.title = ""
        content.subtitle = "2 Days Until Election!"
        content.body = "Remember to look at you pledges!"
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        let request = UNNotificationRequest(identifier: "elections", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }


}

func delay () -> Double{
    return 0.2
}

