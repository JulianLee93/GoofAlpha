//
//  Post.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import UIKit

class Post: NSObject {
    var postedImage = UIImage()
    var user = String()
    var comments = [String]()
    var likes:Int?
}
