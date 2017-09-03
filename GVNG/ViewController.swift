//
//  ViewController.swift
//  GVNG
//
//  Created by Alex Samarchi on 8/31/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func spotifyLoginTapped(_ sender: Any) {
        guard let auth = SpotifyManager.auth() else { return }
        guard let loginURL = SpotifyManager.loginURL() else { return }
        
        if UIApplication.shared.canOpenURL(loginURL) {
            UIApplication.shared.open(loginURL, completionHandler: { (didOpen) in
                print("here")
                print(didOpen)
                if auth.canHandle(auth.redirectURL) {
                    print("can handle")
                }
            })
        }
    }

}

