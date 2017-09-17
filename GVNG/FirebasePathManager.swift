//
//  FirebasePathManager.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/3/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class FirebasePathManager {

    
    //MARK: Ref
    static let ref = Database.database().reference()

    
    //MARK: Users
    
    static func users() -> DatabaseReference {
        return ref.child(DatabasePaths.Users)
    }
    
    
    //MARK: Current User
    
    static func currentUser() -> DatabaseReference {
        return users().child(FirebaseManager.firebaseUserID())
    }
    
    static func currentUsersNowPlaying() -> DatabaseReference {
        return currentUser().child(DatabasePaths.Playing)
    }
    
    
    //MARK: User
    
    static func user(handle: String) -> DatabaseReference {
        return users().child(handle)
    }
    
    static func usersNowPlaying(handle: String) -> DatabaseReference {
        return user(handle: handle).child(DatabasePaths.Playing)
    }
    
    
    //MARK: Music Services
    
    static func musicServices() -> DatabaseReference {
        return currentUser().child(DatabasePaths.MusiceServices)
    }
    
    static func spotify() -> DatabaseReference {
        return musicServices().child(DatabasePaths.Spotify)
    }
    
    static func appleMusic() -> DatabaseReference {
        return musicServices().child(DatabasePaths.AppleMusic)
    }


    //MARK: Syncing
    
    static func setFirebaseDataAtPath(data: [String: Any], path: DatabaseReference) {
        path.setValue(data)
    }
    
    static func updateFirebaseDataAtPath(data: [String: Any], path: DatabaseReference) {
        path.updateChildValues(data)
    }
    
    static func updateChildValues(childUpdates: [String: Any]) {
        ref.updateChildValues(childUpdates)
    }
}
