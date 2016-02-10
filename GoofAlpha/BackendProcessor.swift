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
    
    let baseRef = Firebase(url: "https://goof-alpha-app.firebaseio.com")
    
    var currentUserRef: Firebase {
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
                        let newUser = User.init(email: emailName)
                        let userRef = Firebase(url: "\(self.baseRef)/users")
                        let newUserRef = Firebase(url: "\(userRef)/\(auth.uid)")
                        newUserRef.setValue(newUser.toAnyObject())
                        NSUserDefaults.standardUserDefaults().setValue(auth.uid, forKey: "uid")
                })
            } else {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func uploadPostForUser(uploader: String, image: String) {
        
        let newPost = Post.init(uploader: uploader, image: image)
        let postRef = Firebase(url: "\(self.baseRef)/posts")
        let newPostCreated = postRef.childByAutoId()
        newPostCreated.setValue(newPost.toAnyObject())
        
    }
    
    
    func retrievePostsFromUser(retriever: String) {
        let newRef = Firebase(url: "\(baseRef)/posts")
        newRef.queryOrderedByChild("UID").queryEqualToValue(retriever).observeEventType(FEventType.Value, withBlock: { snapshot in
            for post in snapshot.children {
                let currentPost = Post(snapshot: post as! FDataSnapshot)
                self.currentUserPosts.append(currentPost)
                print(self.currentUserPosts.count)
            }
            })
        
        
        
////        let UID = retriever
//        let newRef = Firebase(url:"\(baseRef)/posts")
//        var myPosts = [Post]()
//        newRef.observeEventType(.Value, withBlock: { snapshot in
//            
//            for post in snapshot.children {
//                let currentPost = Post(snapshot: post as! FDataSnapshot)
//                myPosts.append(currentPost)
//                print("INNER: \(myPosts)")
//            }
//        })
//        print("OUTTER: \(myPosts)")
////        return myPosts
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}