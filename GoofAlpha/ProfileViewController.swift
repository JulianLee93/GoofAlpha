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

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    static let userProfileViewController = ProfileViewController()
    
    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var profilePictureButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    let ref = Firebase(url: "https://goof-alpha-app.firebaseio.com/")
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var userProfile = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        userProfile = BackendProcessor.backendProcessor.currentUserDictionary!
        
        profileCollectionView.backgroundColor = UIColor.whiteColor()
        profilePictureButton.imageView?.image = UIImage(named: "profileimage")
        profilePictureButton.layer.borderWidth = 1.0
        profilePictureButton.layer.masksToBounds = false
        profilePictureButton.layer.borderColor = UIColor.whiteColor().CGColor
        profilePictureButton.layer.cornerRadius = profilePictureButton.frame.size.width/2
        profilePictureButton.clipsToBounds = true
        let profileString = userProfile.objectForKey("profilePic") as! String
        profilePictureButton.setImage(profileString.translateStringToImage(), forState: .Normal)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        BackendProcessor.backendProcessor.pullUser()
        usernameLabel.text = userProfile.objectForKey("name") as? String
        profileCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onProfilePictureTapped(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: {})
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: {})
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        profilePictureButton.setImage(image, forState: .Normal)
        BackendProcessor.backendProcessor.setUserProfilePic(image.translateImageToString())
        print("SET USER PROFILE PICK SHOULD HAVE RAN")
        imagePicker.dismissViewControllerAnimated(true, completion: {
        })
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("FINAL PASS: \(BackendProcessor.backendProcessor.currentUserPosts.count)")
        return BackendProcessor.backendProcessor.currentUserPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profilecell", forIndexPath: indexPath) as! ProfileCollectionViewCell
        
        let postToPost:Post = BackendProcessor.backendProcessor.currentUserPosts[indexPath.row]
        
        let encodedImageData = postToPost.postedImage
        let imageData = NSData(base64EncodedString: encodedImageData, options:.IgnoreUnknownCharacters)
        let image = UIImage(data: (imageData)!)
        
        cell.collectionViewCellImage.image = image
        
        return cell
    }
    
}
