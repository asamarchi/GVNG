//
//  FirebaseManager.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/2/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation

class FirebaseManager {
    
    struct VerificationID {
        static let Key = "authVerificationID"
    }
    
    static let ref = Database.database().reference()
    
    static func setup() {
        FirebaseApp.configure()
    }
    
    static func setAPNSToken(deviceToken: Data) {
        Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
    }
    
    static func setVerificationID(verificationID: String) {
        UserDefaults.standard.set(verificationID, forKey: VerificationID.Key)
    }
    
    static func verificationID() -> String? {
        guard let verificationID = UserDefaults.standard.string(forKey: VerificationID.Key) else { return nil }
        
        return verificationID
    }
    
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
    
    static func signIn(withVerificationCode: String, success: @escaping (User?) -> Swift.Void, failure: @escaping (Error?) -> Swift.Void) {
        guard let verficationID = FirebaseManager.verificationID() else { return }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verficationID, verificationCode: withVerificationCode)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                failure(error)
            }
            
            guard let userID = user?.uid else { return }
            ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    //TODO: Redirect to landing page
                    print(value)
                    success(user)
                } else {
                    ref.child("users").child(userID).setValue(["uid": userID])
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
