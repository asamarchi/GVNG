//
//  LoginPhoneNumberViewController.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/2/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class LoginPhoneNumberViewController: UIViewController {
    
    // MARK: - Properties

    // MARK: IBOutlets

    @IBOutlet var countryCodeAccessoryView: UIView!
    @IBOutlet weak var enterPhoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDesign()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        phoneNumberTextField.becomeFirstResponder()
    }
    
    // MARK: - Private
    
    private func applyDesign() {
        enterPhoneNumberLabel.font = UIFont.gvngOnboardingHeaderFont()
        enterPhoneNumberLabel.textColor = UIColor.gvngBrownishGrey
        
        phoneNumberTextField.font = UIFont.gvngOnboardingTextFieldFont()
        phoneNumberTextField.textColor = UIColor.gvngBrownishGrey
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.keyboardType = UIKeyboardType.phonePad
        phoneNumberTextField.tintColor = UIColor.gvngBrownishGrey
        phoneNumberTextField.inputAccessoryView = countryCodeAccessoryView
        
        countryCodeLabel.font = UIFont.gvngOnboardingCountryCodeFont()
        countryCodeLabel.textColor = UIColor.gvngBrownishGrey
    }
    
    private func showVerificationViewController() {
        guard let verificationViewController = LoginVerificationCodeViewController.instantiateFromStoryboard() else { return }
        
        self.navigationController?.pushViewController(verificationViewController, animated: true)
    }

    private func showPhoneNumberErrorViewController() {
        guard let errorViewController = LoginErrorViewController.instantiateFromStoryboard() else { return }
        errorViewController.errorMessage = "Phone Number Did Not Work"
        
        present(errorViewController, animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let phoneNumber = phoneNumberTextField.text else { return }
        
        //TODO: Change for Country Code implementation
        let concatNumber = "+1\(phoneNumber)"
        
        FirebaseManager.verifyPhoneNumber(phoneNumber: concatNumber, success: {
            self.showVerificationViewController()
        }) { (error) in
            self.showPhoneNumberErrorViewController()
        }
    }
}
