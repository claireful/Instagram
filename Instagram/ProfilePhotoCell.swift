//
//  ProfilePhotoCell.swift
//  Instagram
//
//  Created by Claire Chen on 6/29/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfilePhotoCell: UICollectionViewCell {
    
    //Outlet
    @IBOutlet weak var profileImageView: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            self.profileImageView.file = instagramPost["media"] as? PFFile
            self.profileImageView.loadInBackground()
        }
    }
    
}
