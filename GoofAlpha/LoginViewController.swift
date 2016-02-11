//
//  LoginViewController.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    let ref = Firebase(url: "https://goof-alpha-app.firebaseio.com/")

    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.observeAuthEventWithBlock { (authData) -> Void in
            if authData != nil {
                NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                print("OBSERVE LOGIN AUTH UID IS: \(authData.uid)")
                self.performSegueWithIdentifier("loginMainSegue", sender: self)
            }
        }
        if !(NSUserDefaults.standardUserDefaults().valueForKey("username") == nil){
            loginEmailTextField.text = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
        }
    }
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        ref.authUser(loginEmailTextField.text, password: loginPassTextField.text,
            withCompletionBlock: { (error, auth) in
                print(auth.uid)
                NSUserDefaults.standardUserDefaults().setValue(auth.uid, forKey: "uid")
                BackendProcessor.backendProcessor.retrievePostsFromUser()
                BackendProcessor.backendProcessor.pullUser()
                BackendProcessor.backendProcessor.retrieveAllPosts()
        })
    }
}
