//
//  LoginMusicServiceSelectionViewModel.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/4/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class LoginMusicServiceSelectionViewModel: NSObject {
    
    var musicServices = Variable<[MusicServiceType : MusicService]>([:])
    
    override init() {
        super.init()
        
        setupMusicServices()
        musicServiceObserverAddChild()
    }
    
    deinit {
        FirebasePathManager.ref.removeAllObservers()
        FirebasePathManager.musicServices().removeAllObservers()
    }
    
    func setDefaultMusicServices() {
        self.musicServices.value = [MusicServiceType.Spotify : MusicService("appleMusic", canStream: false), MusicServiceType.AppleMusic : MusicService("spotify", canStream: false)]
    }
    
    func setupMusicServices() {
        FirebasePathManager.musicServices().observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.hasChildren()  {
                self.setDefaultMusicServices()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //when new one is added
    func musicServiceObserverAddChild() {
        FirebasePathManager.musicServices().observe(.childAdded, with: { (snapshot) in
            guard let musicServiceDict = snapshot.value as? [String: Any] else { return }
            guard let musicServiceName = MusicServiceType(rawValue: snapshot.key) else { return }
            
            self.musicServices.value[musicServiceName] = MusicService(musicServiceDict, name: snapshot.key)
        })
    }
}
