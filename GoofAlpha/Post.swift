//
//  Post.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import UIKit

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
    
    
    func toAnyObject() -> AnyObject {
        return [
            "uploader":user,
            "image":postedImage,
            "likes":likes
        ]
    }
}

