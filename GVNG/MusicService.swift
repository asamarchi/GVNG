//
//  MusicService.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/4/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

enum MusicServiceType: String {
    case Spotify = "spotify"
    case AppleMusic = "appleMusic"
}

class MusicService {
    var name: String?
    var canStream: Bool?
    
    convenience init(_ name: String, canStream: Bool) {
        self.init()
        
        self.name = name
        self.canStream = canStream
    }
    
    convenience init(_ dict: [String: Any], name: String) {
        self.init()
        
        self.name = name
        self.canStream = dict["canStream"] as? Bool ?? false
    }
    
    func updateFromDict(_ dict: [String: Any]) {
        self.canStream = dict["canStream"] as? Bool ?? false
    }
}
