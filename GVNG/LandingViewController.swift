//
//  LandingViewController.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/6/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class LandingViewController: UIViewController, Instantiable {
    
    fileprivate struct Storyboard {
        static let Name = "Landing"
        static let Identifier = "LandingViewController"
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
        
        AppleMusicNotificationManager.shared.beginAppleMusicNotifications()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private
    
    @IBAction func playSong(_ sender: Any) {
        AppleMusicNotificationManager.shared.beginAppleMusicNotifications()
        AppleMusicPlayer.shared.playCloserTwice()
    }
    
}
