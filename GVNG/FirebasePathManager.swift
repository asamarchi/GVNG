//
//  FirebasePathManager.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/3/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class FirebasePathManager {

    static let ref = Database.database().reference()

    //MARK: Paths
    
    static func users() -> DatabaseReference {
        return ref.child(DatabasePaths.Users)
    }
    
    static func currentUser() -> DatabaseReference {
        return users().child(FirebaseManager.firebaseUserID())
    }
    
    static func musicServices() -> DatabaseReference {
        return currentUser().child(DatabasePaths.MusiceServices)
    }
    
    static func spotify() -> DatabaseReference {
        return musicServices().child(DatabasePaths.Spotify)
    }
    
    static func appleMusic() -> DatabaseReference {
        return musicServices().child(DatabasePaths.AppleMusic)
    }

}
