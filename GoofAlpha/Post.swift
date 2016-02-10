//
//  Post.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import UIKit
import Firebase

class Post: NSObject {
    var postedImage = String()
    var user = String()
//    var comments = [String]()
    var likes:Int!
    
    
    init(uploader: String, image: String) {
        user = uploader
        postedImage = image
        likes = 0
    }
    
    

    init(snapshot: FDataSnapshot) {
        user = snapshot.value["UID"] as! String
        postedImage = snapshot.value["image"] as! String
        likes = snapshot.value["likes"] as! Int
    }
    
    
    func toAnyObject() -> AnyObject {
        return [
            "UID":user,
            "image":postedImage,
            "likes":likes
        ]
    }
}

