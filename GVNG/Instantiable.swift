//
//  Instantiable.swift
//
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import UIKit


public typealias StoryboardSpecifications = (storyboard: UIStoryboard, identifier: String?)


public protocol Instantiable: class {
    static func storyboardSpecifications() -> StoryboardSpecifications
}


public extension Instantiable {

    public static func instantiateFromStoryboard() -> Self? {
        let specifications = storyboardSpecifications()

        return genericInstantiateFromStoryboard(specifications.storyboard, identifier: specifications.identifier)
    }

    fileprivate static func genericInstantiateFromStoryboard<T>(_ storyboard: UIStoryboard, identifier: String?) -> T? {
        var viewController: T? = nil

        if let identifier = identifier {
            viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T
        }
        else {
            viewController = storyboard.instantiateInitialViewController() as? T
        }

        return viewController
    }
}
