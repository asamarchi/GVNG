//
//  LoginVerificationCodeViewController.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/2/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class LoginVerificationCodeViewController: UIViewController, Instantiable {
    
    // MARK: - Instantiable
    
    private struct Storyboard {
        static let Name = "Login"
        static let Identifier = "LoginVerificationCodeViewController"
    }
    
    static func storyboardSpecifications() -> StoryboardSpecifications {
        let storyboard = UIStoryboard(name: Storyboard.Name, bundle: nil)
        let identifier = Storyboard.Identifier
        return StoryboardSpecifications(storyboard, identifier)
    }
    
    // MARK: Properties
    
    // MARK: IBOutlets
    
    @IBOutlet weak var verificationLabel: UILabel!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet var verificationAccessoryView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        applyDesign()
    }
    
    // MARK: - Private
    
    private func setupTextField() {
        verificationCodeTextField.delegate = self
        verificationCodeTextField.becomeFirstResponder()
    }
    
    private func applyDesign() {
        verificationLabel.font = UIFont.gvngOnboardingHeaderFont()
        verificationLabel.textColor = UIColor.gvngBrownishGrey
        
        verificationCodeTextField.font = UIFont.gvngOnboardingTextFieldFont()
        verificationCodeTextField.textColor = UIColor.gvngBrownishGrey
        verificationCodeTextField.keyboardType = UIKeyboardType.phonePad
        verificationCodeTextField.tintColor = UIColor.gvngBrownishGrey
        verificationCodeTextField.inputAccessoryView = verificationAccessoryView
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let verificationCode = verificationCodeTextField.text else { return }
        
        FirebaseManager.signIn(withVerificationCode: verificationCode, success: { (user) in
            print(user)
        }) { (error) in
            print("failure")
        }
    }
}

extension LoginVerificationCodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        let currentCharacterCount = textField.text?.characters.count ?? 0
        
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        
        let newLength = currentCharacterCount + string.characters.count - range.length
        return newLength <= 6
    }
}
