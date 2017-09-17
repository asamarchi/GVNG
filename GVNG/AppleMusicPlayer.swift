//
//  AppleMusicPlayer.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/6/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import UIKit
import StoreKit
import MediaPlayer

class AppleMusicPlayer: NSObject {
    
    static var shared = AppleMusicPlayer()

    let applicationMusicPlayer = MPMusicPlayerController.systemMusicPlayer()
    
    let serviceController = SKCloudServiceController()
    var storefrontID : String
    
    override init(){
        storefrontID = "0"
        applicationMusicPlayer.beginGeneratingPlaybackNotifications()
    }
    
    static func musicPlayer() -> MPMusicPlayerController {
        return AppleMusicPlayer.shared.applicationMusicPlayer
    }
    
    // Fetch the user's storefront ID
    func appleMusicFetchStorefrontRegion() {
        serviceController.requestStorefrontIdentifier { (storefrontId:String?, err:Error?) -> Void in
            guard err == nil else { return }
            guard let storefrontId = storefrontId else { return }
            
            let startIndex = storefrontId.index(storefrontId.startIndex, offsetBy: 0)
            let fifthLetterIndex = storefrontId.index(storefrontId.startIndex, offsetBy: 4)
            let indexRange = startIndex..<fifthLetterIndex
            self.storefrontID = storefrontId.substring(with: indexRange)
            
            print("Success! The user's storefront ID is: \(self.storefrontID)")
            
        }
    }
    
    func getPlaybackState() -> MPMusicPlaybackState {
        return applicationMusicPlayer.playbackState
    }
    
    func getCurrentPlaybackTime() -> TimeInterval {
        return applicationMusicPlayer.currentPlaybackTime
    }
    
    func setCurrentPlaybackTime(time: TimeInterval) {
        applicationMusicPlayer.currentPlaybackTime = time
    }
    
    func appleMusicPlayTrackId(ids:[String]) {
        applicationMusicPlayer.setQueueWithStoreIDs(ids)
        applicationMusicPlayer.play()
    }
    
    
    func nextSong() {
        applicationMusicPlayer.skipToNextItem()
    }
    
    func prevSong() {
        applicationMusicPlayer.skipToPreviousItem()
    }
    
    func skipToBeginning() {
        applicationMusicPlayer.skipToBeginning()
    }
    
    func playPause() {
        if(applicationMusicPlayer.playbackState==MPMusicPlaybackState.paused){
            applicationMusicPlayer.play()
        } else if(applicationMusicPlayer.playbackState==MPMusicPlaybackState.playing){
            applicationMusicPlayer.pause()
        }
    }
    
    func playCloser() {
        applicationMusicPlayer.setQueueWithStoreIDs(["1170699703"])
        applicationMusicPlayer.play()
    }
    
    func playCloserTwice() {
        appleMusicPlayTrackId(ids: ["1170699703", "1170699703"])
    }
}
