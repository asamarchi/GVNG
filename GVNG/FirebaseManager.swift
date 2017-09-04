//
//  FirebaseManager.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/2/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    let currentUser = Auth.auth().currentUser
    
    //MARK: Constants

    //MARK: Setup
    
    static func setup() {
        FirebaseApp.configure()
    }
    
    //MARK: Getters and Setters
    
    static func setAPNSToken(deviceToken: Data) {
        Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
    }
    
    static func setFirebaseUserID(fireBaseUserID: String) {
        UserDefaultsManager.firebaseUserID = fireBaseUserID
    }
    
    static func firebaseUserID() -> String {
        return UserDefaultsManager.firebaseUserID
    }
    
    static func setVerificationID(verificationID: String) {
        UserDefaultsManager.verificationID = verificationID
    }
    
    static func verificationID() -> String? {
        return UserDefaultsManager.verificationID
    }
    
    
    //MARK: Utilities
    
    static func verifyPhoneNumber(phoneNumber: String, success: @escaping () -> Swift.Void, failure: @escaping (Error?) -> Swift.Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber) { (verificationID, error) in
            if error != nil {
                failure(error)
            }
            
            guard let verificationID = verificationID else { return }
            
            setVerificationID(verificationID: verificationID)
            success()
        }
    }
    
    
    //MARK: Auth
    
    static func signIn(withVerificationCode: String, success: @escaping (User?) -> Swift.Void, failure: @escaping (Error?) -> Swift.Void) {
        guard let verficationID = FirebaseManager.verificationID() else { return }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verficationID, verificationCode: withVerificationCode)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                failure(error)
            }
            
            guard let userID = user?.uid else { return }
            setFirebaseUserID(fireBaseUserID: userID)
            
            FirebasePathManager.currentUser().observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    //TODO: Redirect to landing page
                    print(value)
                    success(user)
                } else {
                    FirebasePathManager.currentUser().setValue([DatabasePaths.UserID: userID])
                    success(user)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
    }
    
    static func canHandleNotification(userInfo: [AnyHashable : Any], completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(UIBackgroundFetchResult.noData)
        }
        
    }
}
