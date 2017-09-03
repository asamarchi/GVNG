//
//  SpotifyManager.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/2/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class SpotifyManager {
    
    static let shared = SpotifyManager()
    
    func setup() {
        guard let auth = SPTAuth.defaultInstance() else { return }
        auth.clientID = "e1111a970fe2475185f1337153b745fa"
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        auth.redirectURL = URL(string: "GVNG://returnAfterLogin")
    }
    
    static func authenticate() {
        guard let auth = SpotifyManager.auth() else { return }
        guard let loginURL = SpotifyManager.loginURL() else { return }
        
        if UIApplication.shared.canOpenURL(loginURL) {
            UIApplication.shared.open(loginURL, completionHandler: { (didOpen) in
                print("here")
                print(didOpen)
                if auth.canHandle(auth.redirectURL) {
                    print("can handle")
                }
            })
        }
    }
    
    static func canHandleAuthCallBack(url: URL) -> Bool {
        guard let auth = SpotifyManager.auth() else { return false }
        
        if auth.canHandle(auth.redirectURL) {
            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
                guard let sptSession = session else { return }
                
                setSpotifySession(spotifySession: sptSession)
                SpotifyManager.getSpotifyUserData(session: sptSession)
            })
            return true
        }
        return false
    }
    
    static func getSpotifyUserData(session: SPTSession) {
        SPTUser.requestCurrentUser(withAccessToken: session.accessToken, callback: { (error, object) -> Void in
            if error != nil {
                print("User look up error: \(error)")
            } else {
                guard let user = object as? SPTUser else { return }
                guard let firebaseUserID = FirebaseManager.firebaseUserID() else { return }
                let productObject = user.product
                
                var userDict: [String: Any] = [
                    "username": user.canonicalUserName
                ]

                if productObject == .unlimited || productObject == .premium {
                    userDict["premium"] = true
                } else {
                    userDict["premium"] = false
                }
                
                if user.displayName != nil {
                    userDict["displayName"] = user.displayName
                }
                
                if user.emailAddress != nil {
                    userDict["email"] = user.emailAddress
                }
                
                if user.images.count != 0 {
                    var image: SPTImage = user.images[0] as! SPTImage
                    if user.images.count > 1 {
                        image = user.images[(user.images.count) - 1] as! SPTImage
                    }
                    userDict["imageURL"] = image.imageURL.absoluteString
                }
                
                FirebaseManager.ref.child("users").child(firebaseUserID).child("spotify").setValue(userDict)
            }
        })
    }
    
    static func setSpotifySession(spotifySession: SPTSession) {
        UserDefaultsManager.spotifySession = spotifySession
    }
    
    static func spotifySession() -> SPTSession? {
        return UserDefaultsManager.spotifySession
    }

    
    static func auth() -> SPTAuth? {
        return SPTAuth.defaultInstance()
    }
    
    static func loginURL() -> URL? {
        return SPTAuth.defaultInstance().spotifyWebAuthenticationURL()
    }
    
}
