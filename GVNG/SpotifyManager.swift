//
//  SpotifyManager.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/2/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class SpotifyManager {
    
//    private let clientID =
////    private let clientSecret = "bdaeb9b1442d4a21b893486984452ecc"
    
    static let shared = SpotifyManager()
    
    
    func setup() {
        guard let auth = SPTAuth.defaultInstance() else { return }
        auth.clientID = "e1111a970fe2475185f1337153b745fa"
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        auth.redirectURL = URL(string: "GVNG://returnAfterLogin")
    }
    
    static func auth() -> SPTAuth? {
        return SPTAuth.defaultInstance()
    }
    
    static func loginURL() -> URL? {
        return SPTAuth.defaultInstance().spotifyWebAuthenticationURL()
    }
    
}
