//
//  AppleMusicNotificationManager.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/6/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation
import MediaPlayer

class AppleMusicNotificationManager: NSObject {
    
    static var shared = AppleMusicNotificationManager()
    
    let musicPlayer = AppleMusicPlayer.musicPlayer()
    var backgroundStoreID: String?
    
    var timer = Timer()
    var listenToFirebaseUser: String?

    
    func beginAppleMusicNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(playbackStateChanged), name:NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nowPlayingItemChanged), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        
        AppleMusicPlayer.shared.applicationMusicPlayer.beginGeneratingPlaybackNotifications()
    }
    
    func endAppleMusicNotifications(callback: (NSObject) -> () ) -> Void {
        musicPlayer.endGeneratingPlaybackNotifications()
    }
    
    func playbackStateChanged(notification: NSNotification) {
        guard let notificationInfo = notification.userInfo else { return }
        guard let key = notificationInfo.values.first as? Int else { return }
        
        if key == 1 {
            print("Playing")
        } else if key == 2 {
            print("Paused")
        }
    }
    
    func nowPlayingItemChanged() {
        saveNewNowPlayingItemToFirebase()
    }
    
    func beginAppleMusicBackgroundListening() -> Void {
        UIApplication.shared.isIdleTimerDisabled = true
        
        if let nowPlayingItem = musicPlayer.nowPlayingItem {
            backgroundStoreID = nowPlayingItem.playbackStoreID
        }
        
        let isLive = true
        
        if isLive {
            DispatchQueue.main.async() {
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.didAppleMusicBackgroundSongChange), userInfo: nil, repeats: true)
            }
        }
        
//        else if listenToUser != nil {
//            listenToFirebaseUser = listenToUser
//            didFirebaseBackgroundSongChange(handle: listenToUser!)
//        } else {
//            print("No one to listen to in the background")
//        }
    }
    
    func endAppleMusicBackgroundListening() -> Void {
        UIApplication.shared.isIdleTimerDisabled = false
        
        timer.invalidate()
        
//        if listenToFirebaseUser != nil {
//            let ref = Database.database().reference()
//            let playing = ref.child("users").child(listenToFirebaseUser!).child("playing")
//            playing.removeAllObservers()
//        }
    }
    
    func didAppleMusicBackgroundSongChange(time: Timer) {
        print("here")
        if backgroundStoreID != musicPlayer.nowPlayingItem?.playbackStoreID {
            print("New song: \((musicPlayer.nowPlayingItem?.title)!)")
            saveNewNowPlayingItemToFirebase()
        }
    }

    func saveNewNowPlayingItemToFirebase() {
        guard
            let currentUserID = FirebaseManager.shared.currentUser?.uid,
            let nowPlayingItem = musicPlayer.nowPlayingItem,
            let title = nowPlayingItem.title,
            let artist = nowPlayingItem.artist else {
                return
        }
        
        let playingDict: [String: Any] = [
            "artist": [
                "text": artist
            ],
            "duration": Int(nowPlayingItem.playbackDuration),
            "service": "apple",
            "started": Int(NSDate().timeIntervalSince1970),
            "track": [
                "id": Int(nowPlayingItem.persistentID),
                "text": title
            ]
        ]
        
        let childUpdates = ["/users/\(currentUserID)/playing/": playingDict]
        FirebasePathManager.updateChildValues(childUpdates: childUpdates)
    }
    
    func didFirebaseBackgroundSongChange(handle: String) {
//        print("Listen to Firebase playback change")
//        
//        FirebasePathManager.usersNowPlaying(handle: handle).observe(.childAdded, with: { (snapshot) in
//            guard let nowPlayingDict = snapshot.value as? [String: Any] else { return }
//
//            var artist: String?
//            if snapshot.key == "artist" {
//                artist = nowPlayingDict["text"] as? String
//            } else {
//                if self.backgroundMusicArtist != nil {
//                    artist = self.backgroundMusicArtist
//                } else {
//                    artist = self.musicPlayer.nowPlayingItem?.artist
//                }
//            }
//            if snapshot.key == "track" {
//                let song = nowPlayingDict["text"] as! String
//                print("Finding track id for: \(song)")
//                AppleMusicSearch().searchAppleMusic(song, artist: artist!, callback: { (object) in
//                    let callback = object as! NSArray
//                    if (callback[0] as! Bool) != false {
//                        let trackID = callback[1] as! String
//                        if #available(iOS 9.3, *) {
//                            self.musicPlayer.setQueueWithStoreIDs([trackID])
//                            self.musicPlayer.play()
//                            self.backgroundMusicSong = self.musicPlayer.nowPlayingItem?.title
//                            self.backgroundMusicArtist = self.musicPlayer.nowPlayingItem?.artist
//                            print("New song: \(self.backgroundMusicSong)")
//                        }
//                    }
//                })
//            }
//        })
    }


}

