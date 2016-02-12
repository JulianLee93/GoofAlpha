//
//  PostingViewController.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class PostingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let ref = Firebase(url: "https://goof-alpha-app.firebaseio.com/")
    let backendServant = BackendProcessor()
    var imagePicker: UIImagePickerController! = UIImagePickerController()
    var imagePickerCamera: UIImagePickerController! = UIImagePickerController()

    //let collectionView = UICollectionView()
    
    @IBOutlet weak var imageToPost: UIImageView!
    var showCamera = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.init(red: 150.0/255.0, green: 50.0/255.0, blue: 200.0/255.0, alpha: 1.0)


        
    }
    
    override func viewDidDisappear(animated: Bool) {
        imageToPost.image = nil
    }
    @IBAction func onCameraButtonTapped(sender: AnyObject) {
        
        imagePickerCamera = UIImagePickerController()
        imagePickerCamera.delegate = self
        imagePickerCamera.sourceType = .Camera
        presentViewController(imagePickerCamera, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
//        imagePicker.delegate = self
        
//        if !showCamera {
//            presentViewController(imagePicker, animated: true, completion: {})
//            showCamera = true
//        }else{
//            showCamera = false
//        }
        
        // Do any additional setup after loading the view.
        
        //if (UIImagePickerController.isSourceTypeAvailable(.Camera)){
            //if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil{
                //imagePicker.allowsEditing = false
                //imagePicker.sourceType = .Camera
                //imagePicker.cameraCaptureMode = .Photo
                //presentViewController(imagePicker, animated: true, completion: {})
            //}else{
                //alert
            //}
        //}else{
            //alert
        //}
    }
    
    @IBAction func onPostButtonTapped(sender: UIButton) {
        
        let uploader = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        print(uploader)
        
        

        let imageString = UIImageJPEGRepresentation(imageToPost.image!, 0.5)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
        
        backendServant.uploadPostForUser(uploader, image: imageString!)
        
        tabBarController?.selectedIndex = 0
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        //if 
        
        imageToPost.image = image
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imagePickerCamera.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: {})
        tabBarController?.selectedIndex = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
