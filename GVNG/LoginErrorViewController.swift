//
//  LoginErrorViewController.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/2/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class LoginErrorViewController: UIViewController, Instantiable {
    
    fileprivate struct Storyboard {
        static let Name = "Login"
        static let Identifier = "LoginErrorViewController"
    }
    
    // MARK: - Properties
    
    var errorMessage: String = ""
    
    // MARK: IBOutlets

    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDesign()
        dismissAfterTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        errorMessageLabel.text = errorMessage
    }
    
    // MARK: - Private
    
    private func applyDesign() {
        errorTitleLabel.font = UIFont.gvngErrorTitleFont()
        errorTitleLabel.textColor = UIColor.gvngWhite
        
        errorMessageLabel.font = UIFont.gvngErrorSubtitleFont()
        errorMessageLabel.textColor = UIColor.gvngWhite
    }
    
    private func dismissAfterTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    static func storyboardSpecifications() -> StoryboardSpecifications {
        let storyboard = UIStoryboard(name: Storyboard.Name, bundle: nil)
        let identifier = Storyboard.Identifier
        return StoryboardSpecifications(storyboard, identifier)
    }

}
