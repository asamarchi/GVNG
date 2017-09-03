//
//  NSURL+CacheFiles.swift

//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation


extension URL {
    static func cacheFile(named name: String, searchPathDirectory: FileManager.SearchPathDirectory = .cachesDirectory) -> URL {
        let cachesDirectory = try! FileManager.default.url(for: searchPathDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        // swiftlint:disable:previous force_try

        let cacheFileURL = cachesDirectory.appendingPathComponent(name)

        return cacheFileURL
    }
}
