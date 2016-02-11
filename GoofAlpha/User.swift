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
    var name: String
    var email: String
    var profilePic: String = ""
    
    // Initialize from Firebase
    init(authData: FAuthData) {
        name = authData.providerData["name"] as! String
        email = authData.providerData["email"] as! String
        profilePic = authData.providerData["profilePic"] as! String
    }
    
    // Initialize from arbitrary data
    init(name: String, email: String, profilePic: String) {
        self.name = name
        self.email = email
        self.profilePic = profilePic
    }
    
    
    init(snapshot: FDataSnapshot) {
        name = snapshot.value["name"] as! String
        email = snapshot.value["email"] as! String
        profilePic = snapshot.value["profilePic"] as! String
    }
    
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "email":email,
            "profilePic":profilePic
        ]
    }
}