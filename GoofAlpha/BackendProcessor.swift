//
//  BackendProcessor.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import Foundation
import Firebase

class BackendProcessor {
    static let backendProcessor = BackendProcessor()
    
    let baseRef = Firebase(url: "https://goof-alpha-app.firebaseio.com/")
    
    var currentUserRef: Firebase
        {
            let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
            let currentUser = Firebase(url: "\(baseRef)").childByAppendingPath("users").childByAppendingPath(userID)
            return currentUser!
    }
    
    func createAuthAndDataForUser(emailField: String, passwordField: String) {
        self.baseRef.createUser(emailField, password: passwordField) { (error, result) -> Void in
            if error == nil {
                self.baseRef.authUser(emailField, password: passwordField,
                    withCompletionBlock: { (error, auth) -> Void in
                        let emailArray = emailField.componentsSeparatedByString("@")
                        let emailName = emailArray[0]
                        let newUser = User.init(uid: auth.uid, email: emailName)
                        let userRef = Firebase(url: "\(self.baseRef)/users")
                        let newUserRef = userRef.childByAppendingPath(emailName)
                        newUserRef.setValue(newUser.toAnyObject())
                })
            } else {
                print(error.localizedDescription)
            }
        }
    }
    
    func uploadPostForUser() {
        
//        self.baseRef.setValue(<#T##value: AnyObject!##AnyObject!#>)
    }
    
}