//
//  LoginMusicServiceSelectionViewController.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/3/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class LoginMusicServiceSelectionViewController: UIViewController, Instantiable {
    
    fileprivate struct Storyboard {
        static let Name = "Login"
        static let Identifier = "LoginMusicServiceSelectionViewController"
    }
    
    static func storyboardSpecifications() -> StoryboardSpecifications {
        let storyboard = UIStoryboard(name: Storyboard.Name, bundle: nil)
        let identifier = Storyboard.Identifier
        return StoryboardSpecifications(storyboard, identifier)
    }
    
    // MARK: - Properties
    
    var refHandle: UInt = 0
    
    // MARK: IBOutlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var appleMusicButton: UIButton!
    @IBOutlet weak var appleMusicCheck: UIImageView!
    @IBOutlet weak var spotifyButton: UIButton!
    @IBOutlet weak var spotifyCheck: UIImageView!
    @IBOutlet weak var soundcloudButton: UIButton!
    @IBOutlet weak var soundCloudCheck: UIImageView!
    @IBOutlet weak var googleMusicButton: UIButton!
    @IBOutlet weak var googleMusicCheck: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDesign()
        
        guard let firebaseUserID = FirebaseManager.firebaseUserID() else { return }
        
        refHandle = FirebaseManager.ref.child("users").child(firebaseUserID).child("spotify").observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            print(snapshot.value)
            // check to see if there is a spotify object and/or an apple object from snapshot.value.
            // if so, update check on button.
        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private
    
    private func applyDesign() {
        messageLabel.font = UIFont.gvngOnboardingHeaderFont()
        messageLabel.textColor = UIColor.gvngBrownishGrey
    }
    
    @IBAction func appleMusicTapped(_ sender: Any) {
        appleMusicCheck.isHidden = appleMusicButton.isSelected
    }
    
    @IBAction func spotifyTapped(_ sender: Any) {
        
        SpotifyManager.authenticate()

//        //TODO: Callback show check
//        spotifyCheck.isHidden = spotifyButton.isSelected
    }
    
    @IBAction func soundCloudTapped(_ sender: Any) {
//        soundCloudCheck.isHidden = soundcloudButton.isSelected
    }
    
    @IBAction func googleMusicTapped(_ sender: Any) {
//        googleMusicCheck.isHidden = googleMusicButton.isSelected
    }
}
