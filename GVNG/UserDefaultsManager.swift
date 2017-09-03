//
//  UserDefaultsManager.swift
//
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation
import UIKit


class UserDefaultsManager: NSObject {

    // MARK: - Constants
    
    struct VerificationID {
        static let Key = "authVerificationID"
        static let Default = ""
    }
    
    struct FireBaseUserID {
        static let Key = "fireBaseUserID"
        static let Default = ""
    }
    
    struct SpotifySession {
        static let Key = "spotifySession"
        static let Default = SPTSession()
    }
    
    // MARK: - Statics
    
    static func registerDefaults() {
        let inauguralDefaults = UserDefaultsManager.inauguralDefaults()
        UserDefaults.standard.register(defaults: inauguralDefaults)
    }
    
    
    fileprivate static func inauguralDefaults() -> [String: Any] {
        let defaults = [String: Any]()
        return defaults
    }


    fileprivate static func setObject(_ object: Any?, forKey key: String) {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    // MARK: - Properties
    
    static var verificationID: String {
        get {
            guard let verificationID = UserDefaults.standard.string(forKey: VerificationID.Key) else { return VerificationID.Default }
            return verificationID
        }
        set {
            setObject(newValue, forKey: VerificationID.Key)
        }
    }
    
    static var firebaseUserID: String {
        get {
            guard let firebaseUserID = UserDefaults.standard.string(forKey: FireBaseUserID.Key) else { return FireBaseUserID.Default }
            return firebaseUserID
        }
        set {
            setObject(newValue, forKey: FireBaseUserID.Key)
        }
    }
    
    static var spotifySession: SPTSession {
        get {
            guard let archivedSpotifySession = UserDefaults.standard.object(forKey: SpotifySession.Key) as? Data else { return SpotifySession.Default }
            
            let unarchived = NSKeyedUnarchiver(forReadingWith: archivedSpotifySession)
            guard let spotifySession = unarchived.decodeObject(forKey: "root") as? SPTSession else { return SpotifySession.Default }
            return spotifySession
        }
        set {
            let sessionData = NSKeyedArchiver.archivedData(withRootObject: spotifySession)
            setObject(sessionData, forKey: SpotifySession.Key)
        }
    }
}

