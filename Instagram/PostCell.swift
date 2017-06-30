//
//  PostCell.swift
//  Instagram
//
//  Created by Claire Chen on 6/28/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var usernameLabel: UILabel!

    @IBOutlet weak var profImageView: PFImageView!
    
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var instagramPost: PFObject! {
        didSet {
            postImageView.file = instagramPost["media"] as? PFFile
            postImageView.loadInBackground()
            captionLabel.text = instagramPost["caption"] as? String
            let user = instagramPost["author"] as? PFUser
            usernameLabel.text = user?.username
            print("Sad")
            profImageView.file = user?.object(forKey: "prof_pic") as? PFFile
            profImageView.loadInBackground()
            print(PFUser.current()?.object(forKey: "description") as? String)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
