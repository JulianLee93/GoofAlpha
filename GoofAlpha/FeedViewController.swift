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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 13
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("feedcell") as! FeedTableViewCell
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
