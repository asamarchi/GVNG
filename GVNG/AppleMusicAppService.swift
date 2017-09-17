//
//  AppleMusicAppService.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/9/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class AppleMusicAppService: NSObject, GVNGAppService {
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        AppleMusicNotificationManager.shared.beginAppleMusicBackgroundListening()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        AppleMusicNotificationManager.shared.endAppleMusicBackgroundListening()
    }
}
