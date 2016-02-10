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
    
    
    func retrievePostsFromUser(retriever: String){
        let newRef = Firebase(url: "\(baseRef)/posts")
        newRef.queryOrderedByChild("UID").queryEqualToValue(retriever).observeEventType(FEventType.Value, withBlock: { snapshot in

            self.currentUserPosts = [Post]()
            for post in snapshot.children {
                let currentPost = Post(snapshot: post as! FDataSnapshot)
                self.currentUserPosts.append(currentPost)
            }
            print(self.currentUserPosts.count)

        })

    }
    
    
    func pullUser(retriever: String) -> AnyObject {
        let newRef = Firebase(url: "\(baseRef)/users")
        newRef.queryOrderedByChild("UID").queryEqualToValue(retriever).observeEventType(FEventType.Value, withBlock: { snapshot in
            
            //let nowUser = snapshot.children as User
        })
        
        return 0 //return the user
    }
    
    
    func uploadCommentForPost(uploader: String, image: String, comment: String) {
        
        let newComment = Comment.init(uploader: uploader, image: image, comment: comment)
        let comRef = Firebase(url: "\(self.baseRef)/comments")
        let newCommentCreated = comRef.childByAutoId()
        newCommentCreated.setValue(newComment.toAnyObject())
        
    }
    
    //func pull comments array based on image
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}