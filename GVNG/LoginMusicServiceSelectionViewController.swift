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
    
    var spotifyObserver: UInt = 0
    var appleMusicObserver: UInt = 0

    
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
    
    @IBOutlet weak var nextButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDesign()
        
        attachObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        detachObservers()
    }
    // MARK: - Private
    
    private func attachObservers() {
        
        spotifyObserver = FirebasePathManager.spotify().observe(DataEventType.value, with: { (snapshot) in
            guard let spotifyDict = snapshot.value as? [String: Any] else { return }
            guard let canStream = spotifyDict["canStream"] as? Bool, canStream == true else { return }
            
            self.updateCheck(shouldShowCheck: !canStream, check: self.spotifyCheck)
        })
                
        appleMusicObserver = FirebasePathManager.appleMusic().observe(DataEventType.value, with: { (snapshot) in
            guard let appleMusicDict = snapshot.value as? [String: Any] else { return }
            guard let canStream = appleMusicDict["canStream"] as? Bool, canStream == true else { return }
            
            self.updateCheck(shouldShowCheck: !canStream, check: self.appleMusicCheck)
        })
    }
    
    private func updateNextButton() {
        
    }
    
    private func updateCheck(shouldShowCheck: Bool, check: UIImageView) {
        check.isHidden = shouldShowCheck
    }
    
    private func detachObservers() {
        FirebasePathManager.ref.removeObserver(withHandle: self.spotifyObserver)
    }
    
    private func applyDesign() {
        messageLabel.font = UIFont.gvngOnboardingHeaderFont()
        messageLabel.textColor = UIColor.gvngBrownishGrey
    }
    
    @IBAction func appleMusicTapped(_ sender: Any) {
        AppleMusicManager.appleMusicRequestPermission()
        //appleMusicCheck.isHidden = appleMusicButton.isSelected
    }
    
    @IBAction func spotifyTapped(_ sender: Any) {
        SpotifyManager.authenticate()
    }
    
    @IBAction func soundCloudTapped(_ sender: Any) {
//        soundCloudCheck.isHidden = soundcloudButton.isSelected
    }
    
    @IBAction func googleMusicTapped(_ sender: Any) {
//        googleMusicCheck.isHidden = googleMusicButton.isSelected
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
    }
}
