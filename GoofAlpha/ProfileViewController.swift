//
//  ProfileViewController.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let ref = Firebase(url: "https://goof-alpha-app.firebaseio.com/")
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var profilePostJSON = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        //
        
        let UID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        BackendProcessor.backendProcessor.retrievePostsFromUser(UID)
        
        if (BackendProcessor.backendProcessor.currentUserPosts.count > 0){
            let postToPost:Post = BackendProcessor.backendProcessor.currentUserPosts[0]
            
            
            print(postToPost.postedImage)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    ONBUTTONTAPPED(){
//        presentViewController(imagePicker, animated: true, completion: {})
//    
//    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
//        imageToPost if your profile picture button
//        button.setimage = image //{
        
        imagePicker.dismissViewControllerAnimated(true, completion: {
            
        })
    }
}
