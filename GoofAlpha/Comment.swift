//
//  Comment.swift
//  GoofAlpha
//
//  Created by Adish Padhani on 2/10/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import UIKit

class Comment: NSObject {

    var Image = String()
    var user = String()
    var Comment = String()
    
    init(uploader: String, image: String, comment: String) {
        user = uploader
        Image = image
        Comment = comment
    }
    
    
    func toAnyObject() -> AnyObject {
        return [
            "UID":user,
            "image":Image,
            "comment":Comment
        ]
    }
}
