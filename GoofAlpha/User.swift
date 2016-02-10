//
//  User.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let email: String
    
    // Initialize from Firebase
    init(authData: FAuthData) {
        uid = authData.uid
        email = authData.providerData["email"] as! String
    }
    
    // Initialize from arbitrary data
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "email": email,
            "UID": uid
        ]
    }
}