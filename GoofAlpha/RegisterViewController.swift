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
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var password1Label: UILabel!
    @IBOutlet weak var password2Label: UILabel!
    @IBOutlet weak var registerEmailTextField: UITextField!
    
    @IBOutlet weak var registerPassTextField: UITextField!
    
    @IBOutlet weak var registerCheckPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 150.0/255.0, green: 50.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        registerEmailTextField.backgroundColor = UIColor.whiteColor()
        registerPassTextField.backgroundColor = UIColor.whiteColor()
        registerCheckPassTextField.backgroundColor = UIColor.whiteColor()
        emailLabel.textColor = UIColor.whiteColor()
        password1Label.textColor = UIColor.whiteColor()
        password2Label.textColor = UIColor.whiteColor()


    }

    @IBAction func registerButtonTapped(sender: UIButton) {
        let emailField = registerEmailTextField.text
        let passwordField = registerPassTextField.text
        NSUserDefaults.standardUserDefaults().setValue(emailField, forKey: "username")
        backendServant.createAuthAndDataForUser(emailField!, passwordField: passwordField!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
