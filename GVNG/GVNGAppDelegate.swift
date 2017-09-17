//
//  GVNGAppDelegate.swift
//  GVNG
//
//  Created by Alex Samarchi on 8/31/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class GVNGAppDelegate: ServiceableApplicationDelegate {
    
    override var services: [GVNGAppService] {
        return [
            FirebaseAppService(),
            SpotifyAppService(),
            PushNotificationsAppService(),
            AppleMusicAppService()
        ]
    }
}

