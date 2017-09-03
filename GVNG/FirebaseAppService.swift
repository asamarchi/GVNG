//
//  FirebaseAppService.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/3/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class FirebaseAppService: NSObject, GVNGAppService {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        FirebaseManager.setAPNSToken(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        FirebaseManager.canHandleNotification(userInfo: userInfo, completionHandler: completionHandler)
    }
    
}
