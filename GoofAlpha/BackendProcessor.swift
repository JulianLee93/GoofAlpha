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
    var currentUserPosts = [Post]()
    var feedPostArray = [Post]()
    var currentUserDictionary:NSDictionary?
    let baseRef = Firebase(url: "https://goof-alpha-app.firebaseio.com")
    
    var currentUserRef: String! {
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil {
            let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
            return userID
        } else {
            print("NSUserDefaults NOT SET")
            return nil
        }
    }
    
    
    
    func createAuthAndDataForUser(emailField: String, passwordField: String) {
        self.baseRef.createUser(emailField, password: passwordField) { (error, result) -> Void in
            if error == nil {
                print("AUTH RESULT: \(result["uid"]!)")
                let emailArray = emailField.componentsSeparatedByString("@")
                let emailName = emailArray[0]
                let newUser = User.init(name: emailName, email: emailField, profilePic: "")
                let userRef = Firebase(url: "\(self.baseRef)/users")
                let newUserRef = Firebase(url: "\(userRef)/\(result["uid"]!)")
                newUserRef.setValue(newUser.toAnyObject())
                NSUserDefaults.standardUserDefaults().setValue(result["uid"], forKey: "uid")
            } else {
                print("CREATE USER ERROR: \(error.localizedDescription)")
//                let AlertController = UIAlertController.init(title: "User didn't create.", message: "Try again", preferredStyle: )
            }
        }
    }
    
    
    
    func uploadPostForUser(uploader: String, image: String) {
        let newPost = Post.init(uploader: uploader, image: image)
        let postRef = Firebase(url: "\(self.baseRef)/posts")
        let newPostCreated = postRef.childByAutoId()
        newPostCreated.setValue(newPost.toAnyObject())
    }
    
    
    
    func retrievePostsFromUser() {
        
        
        
        print("RETRIEVE POSTS FROM USER IS BEING CALLED NOW")
        let newRef = Firebase(url: "\(baseRef)/posts")
        newRef.queryOrderedByChild("UID").queryEqualToValue(currentUserRef).observeEventType(FEventType.Value, withBlock: { snapshot in
            self.currentUserPosts = [Post]()
            for post in snapshot.children {
                let currentPost = Post(snapshot: post as! FDataSnapshot)
                self.currentUserPosts.append(currentPost)
            }
            print("COUNT OF CURRENT USER POSTS: \(self.currentUserPosts.count)")
        })
    }
    
    
    func retrieveAllPosts(){
        let newRef = Firebase(url: "\(baseRef)/posts")
        newRef.queryOrderedByChild("likes").observeEventType(FEventType.Value, withBlock: { snapshot in
            self.feedPostArray = [Post]()
            for post in snapshot.children {
                let currentPost = Post(snapshot: post as! FDataSnapshot)
                self.feedPostArray.append(currentPost)
            }
            print("COUNT OF ALL USER POSTS: \(self.feedPostArray.count)")
        })
    }
    
    
    
    func setUserProfilePic(imageString: String) {
        let userProfilePicRef = Firebase(url: "\(baseRef)/users/\(currentUserRef)")
        userProfilePicRef.updateChildValues(["profilePic":imageString])
    }
    
    
    
    
    func pullUser() {
        let userDataRef = baseRef.childByAppendingPath("users").childByAppendingPath(currentUserRef)
        let urlString = String(format: "%@.json", userDataRef.description)
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            do {
                print("USER DATA PULL COMPLETED")
                self.currentUserDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
                print(self.currentUserDictionary?.objectForKey("name"))
                print(self.currentUserDictionary?.objectForKey("email"))

            } catch let error as NSError {
                print("Pull user error:"+error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    func uploadCommentForPost(uploader: String, image: String, comment: String) {
        
        let newComment = Comment.init(uploader: uploader, image: image, comment: comment)
        let comRef = Firebase(url: "\(self.baseRef)/comments")
        let newCommentCreated = comRef.childByAutoId()
        newCommentCreated.setValue(newComment.toAnyObject())
        
    }
    
    //func pull comments array based on image
    
    
    
    
    
    
}



extension UIImage {
    
    func translateImageToString() -> String {
        let imageString = UIImageJPEGRepresentation(self, 0.5)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
        return imageString!
    }
}

extension String {
    func translateStringToImage() -> UIImage {
        let imageData = NSData(base64EncodedString: self, options:.IgnoreUnknownCharacters)
        let image = UIImage(data: (imageData)!)!
        return image
    }
}




