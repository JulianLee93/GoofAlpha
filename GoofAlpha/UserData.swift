//
//  UserData.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import Foundation
import Firebase

struct UserData {
    
    let key: String!
    let email: String!
    let ref: Firebase?
    
    // Initialize from arbitrary data
    init(email: String, key: String = "") {
        self.key = key
        self.email = email
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        email = snapshot.value["email"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "email": email,
            "friends": []
        ]
    }
    
}