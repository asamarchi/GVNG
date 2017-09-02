//
//  FirebaseManager.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/2/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class FirebaseManager {
    
    static let ref = Database.database().reference()
    
    static func setup() {
        FirebaseApp.configure()
    }
}
