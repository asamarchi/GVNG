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
    
    let viewModel = LoginMusicServiceSelectionViewModel()
    
    var checks: [MusicServiceType: UIImageView] = [:]
    
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

    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChecks()
        applyDesign()
        attachObservers()
        updateNextButton()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        detachObservers()
    }
    
    
    // MARK: - Private
    
    private func applyDesign() {
        messageLabel.font = UIFont.gvngOnboardingHeaderFont()
        messageLabel.textColor = UIColor.gvngBrownishGrey
    }
    
    private func setupChecks() {
        checks = [MusicServiceType.AppleMusic : appleMusicCheck, MusicServiceType.Spotify : spotifyCheck]
    }
    
    private func attachObservers() {
        viewModel.musicServices.asObservable().subscribe( onNext: { bool in
            self.updateChecks()
            self.updateNextButton()
        })
    }
    
    private func updateChecks() {
        for musicService in viewModel.musicServices.value.values {
            updateCheckForMusiceService(musicService: musicService)
        }
    }
    
    private func updateCheckForMusiceService(musicService: MusicService) {
        guard let canStream = musicService.canStream else { return }
        guard let name = musicService.name else { return }
        guard let check = self.musicServiceCheck(musicServiceName: name) else { return }
        
        self.updateCheck(shouldShowCheck: !canStream, check: check)
    }
    
    private func musicServiceCheck(musicServiceName: String) -> UIImageView? {
        guard let musicServiceType = MusicServiceType(rawValue: musicServiceName) else { return nil }
        return checks[musicServiceType]
    }
    
    private func updateCheck(shouldShowCheck: Bool, check: UIImageView) {
        check.isHidden = shouldShowCheck
    }
    
    private func detachObservers() {
        FirebasePathManager.ref.removeObserver(withHandle: self.spotifyObserver)
    }
    
    
    //MARK: IBActions
    
    @IBAction func appleMusicTapped(_ sender: Any) {
        AppleMusicManager.appleMusicRequestPermission()
        //appleMusicCheck.isHidden = appleMusicButton.isSelected
    }
    
    @IBAction func spotifyTapped(_ sender: Any) {
        SpotifyManager.authenticate()
    }
    
    @IBAction func soundCloudTapped(_ sender: Any) {
        //TODO: Implement
    }
    
    @IBAction func googleMusicTapped(_ sender: Any) {
        //TODO: Implement
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        //TODO: Landing Page
        dismiss(animated: true, completion: nil)
    }
    
    private func updateNextButton() {
        for musicService in viewModel.musicServices.value.values {
            guard let canStream = musicService.canStream else { return }
            
            if canStream {
                nextButton.isHidden = false
                break
            } else {
                nextButton.isHidden = true
            }
        }
    }
}

