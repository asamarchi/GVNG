//
//  SpotifyAppService.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/3/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class SpotifyAppService: NSObject, GVNGAppService {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let auth = SpotifyManager.auth() else { return false }
        
        if auth.canHandle(auth.redirectURL) {
            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
                print("here")
            })
            return true
        }
        
        return false
    }
    
}
