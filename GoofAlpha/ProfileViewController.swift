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

        let UID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        BackendProcessor.backendProcessor.retrievePostsFromUser(UID)
        
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(animated: Bool) {
//        let url = NSURL(string: "\(ref)/posts")
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
//            do{
//                self.profilePostJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
//            }
//            
//            catch let error as NSError{
//                print(error.localizedDescription)
//            }
//
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                //reload feed here
//                print(self.profilePostJSON)
//            })
//            
//            
//        }
//    
//        task.resume()
//    }
    
    override func viewDidAppear(animated: Bool) {
        //
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
