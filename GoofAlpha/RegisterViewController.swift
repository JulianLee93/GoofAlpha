//
//  RegisterViewController.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    let ref = Firebase(url: "https://goof-alpha-app.firebaseio.com/")
    let backendServant = BackendProcessor()
    
    @IBOutlet weak var registerEmailTextField: UITextField!
    
    @IBOutlet weak var registerPassTextField: UITextField!
    
    @IBOutlet weak var registerCheckPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.observeAuthEventWithBlock { (authData) -> Void in
            if authData != nil {
                    self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }

    @IBAction func registerButtonTapped(sender: UIButton) {
        let emailField = registerEmailTextField.text
        let passwordField = registerPassTextField.text
        
        backendServant.createAuthAndDataForUser(emailField!, passwordField: passwordField!)
    }
    
}
