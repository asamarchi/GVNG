//
//  PushNotificationsAppService.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/3/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation
import UserNotifications

class PushNotificationsAppService: NSObject, GVNGAppService {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
                UIApplication.shared.registerForRemoteNotifications()
            })
        }
                
        return true
    }
    
}
