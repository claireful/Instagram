//
//  PostDetailsViewController.swift
//  Instagram
//
//  Created by Claire Chen on 6/28/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostDetailsViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!

    //Variable
    var post: PFObject?
    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = user?.username
        captionLabel.text = post?["caption"] as! String
        let likes = post?["likesCount"] as! Int
        likesLabel.text = "Liked by " + String(likes)
        
        postImageView.file = post?["media"] as? PFFile
        postImageView.loadInBackground()
        
        //some date formatting
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:post?.createdAt as! Date)
        timestampLabel.text = dateString

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
