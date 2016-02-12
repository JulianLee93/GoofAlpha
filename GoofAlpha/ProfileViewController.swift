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

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    static let userProfileViewController = ProfileViewController()
    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var emojiPickerView: UIPickerView!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var profilePictureButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    let ref = Firebase(url: "https://goof-alpha-app.firebaseio.com/")
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var userProfile = NSDictionary()
    var emojiArray = [String]()
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiLabel.hidden = true
        emojiArray = ["😁", "😂", "😃", "😄", "😅", "😆", "😇", "😈", "😉", "😊", "😋", "😌", "😍", "😎", "😏", "😐", "😑", "😒", "😓", "😔", "😕", "😖", "😗", "😘", "😙", "😚", "😛", "😜", "😝", "😞", "😟", "😠", "😡", "😢", "😣", "😤", "😥", "😦", "😧", "😨", "😩", "😪", "😫", "😬", "😭", "😮", "😯", "😰", "😱", "😲", "😳", "😴", "😵", "😶", "😷", "😸", "😹", "😺", "😻", "😼", "😽", "😾", "😿", "🙀", "🙁", "🙂", "🙃", "🙄", "🙅", "🙆", "🙇", "🙈", "🙉", "🙊", "🙋", "🙌", "🙍", "🙎", "🙏", "🙌", "👏", "👋", "👍", "👊", "✊", "✌️", "👌", "✋", "💪", "☝️", "👆", "👇", "👈", "👉", "🖕", "🤘", "🖖"]
        
        self.view.backgroundColor = UIColor.init(red: 100.0/255.0, green: 100.0/255.0, blue:225.0/255.0, alpha: 1.0)
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
        
        BackendProcessor.backendProcessor.pullUser()
        usernameLabel.text = userProfile.objectForKey("name") as? String
        usernameLabel.textColor = UIColor.whiteColor()
        profileCollectionView.reloadData()

    }
    
    
    
    @IBAction func logoutButton(sender: UIButton) {
        let currentUserUID = BackendProcessor.backendProcessor.currentUserRef
        let currentUserRef = Firebase(url: "\(ref)/users/\(currentUserUID)")
        currentUserRef.unauth()
    }
    
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emojiArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return emojiArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        emojiLabel.text = emojiArray[row]
        emojiPickerView.hidden = true
        emojiLabel.hidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    // UICollectionViewDelegateFlowLayout Method #1
//    override func viewWillLayoutSubviews() {
//        profileCollectionView.collectionViewLayout.invalidateLayout()
//    }
//    
//    // UICollectionViewDelegateFlowLayout Method #2
//    func collectionview(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        var itemsCount : CGFloat = 2.0
//        if UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.Portrait {
//            itemsCount = 3.0
//        }
//        return CGSize(width: self.view.frame.width/itemsCount - 20, height: 100/100 * (self.view.frame.width/itemsCount - 20))
//    }
    
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
