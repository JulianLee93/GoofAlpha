//
//  FeedViewController.swift
//  GoofAlpha
//
//  Created by Julian Lee on 2/9/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let ref = Firebase(url: "https://goof-alpha-app.firebaseio.com/")

    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 50.0/255.0, green: 150.0/255.0, blue: 100.0/255.0, alpha: 1.0)

        BackendProcessor.backendProcessor.retrievePostsFromUser()
        BackendProcessor.backendProcessor.pullUser()
        BackendProcessor.backendProcessor.retrieveAllPosts()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        feedTableView.reloadData()
        print("FEED COUNT: \(BackendProcessor.backendProcessor.feedPostArray.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return BackendProcessor.backendProcessor.feedPostArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell") as! FeedTableViewCell
        let feedPostArray = BackendProcessor.backendProcessor.feedPostArray
        let post = feedPostArray[feedPostArray.count - 1 - indexPath.row]
        cell.usernameLabel.text = post.user
        let imageString = post.postedImage
        cell.feedImageView.image = imageString.translateStringToImage()
        cell.backgroundColor = UIColor.init(red: 50.0/255.0, green: 150.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        
        return cell
        
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
