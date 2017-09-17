//
//  SplashScreenViewController.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/5/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class SplashScreenViewController: UIViewController, Instantiable {
    
    fileprivate struct Storyboard {
        static let Name = "Main"
        static let Identifier = "SplashScreenViewController"
    }
    
    static func storyboardSpecifications() -> StoryboardSpecifications {
        let storyboard = UIStoryboard(name: Storyboard.Name, bundle: nil)
        let identifier = Storyboard.Identifier
        return StoryboardSpecifications(storyboard, identifier)
    }
    
    // MARK: - Properties
    
    // MARK: IBOutlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaultsManager.firebaseUserID == UserDefaultsManager.FireBaseUserID.Default {
            performSegue(withIdentifier: "toLogin", sender: self)
        } else {
            performSegue(withIdentifier: "toLanding", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private
    

}
