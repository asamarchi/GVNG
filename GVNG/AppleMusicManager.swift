//
//  AppleMusicManager.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/3/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation
import StoreKit

class AppleMusicManager {
    static let shared = AppleMusicManager()
    
    static func appleMusicRequestPermission() {
        SKCloudServiceController.requestAuthorization { (status:SKCloudServiceAuthorizationStatus) in
            switch status {
            case .authorized:
                appleMusicCheckIfDeviceCanPlayback()
                print("The user tapped 'Allow'")
            case .denied:
                print("The user tapped 'Don't allow'. Read on about that below...")
            case .notDetermined:
                print("The user hasn't decided or it's not clear whether they've confirmed or denied.")
            case .restricted:
                print("User may be restricted; for example, if the device is in Education mode, it limits external Apple Music usage. This is similar behaviour to Denied.")
            }
        }
    }
    
    static func appleMusicCheckIfDeviceCanPlayback() {
        let serviceController = SKCloudServiceController()
        serviceController.requestCapabilities { (capability:SKCloudServiceCapability, err:Error?) in
            if capability.contains(SKCloudServiceCapability.musicCatalogPlayback) {
                syncAppleMusicDataToFirebase()
                print("The user has an Apple Music subscription and can playback music!")
            } else if  capability.contains(SKCloudServiceCapability.addToCloudMusicLibrary) {
                print("The user has an Apple Music subscription, can playback music AND can add to the Cloud Music Library")
            } else {
                print("The user doesn't have an Apple Music subscription available. Now would be a good time to prompt them to buy one?")
            }
        }  
    }
    
    static func syncAppleMusicDataToFirebase() {
        var userDict: [String: Any] = [:]
        userDict["canStream"] = true        
        FirebasePathManager.syncDataToFirebase(data: userDict, path: FirebasePathManager.appleMusic())
    }
}
