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
    
    func randomColor() -> UIColor{
        var randomRed:CGFloat = CGFloat(arc4random_uniform(256))
        print(randomRed)
        var randomGreen:CGFloat = CGFloat(arc4random_uniform(256))
        var randomBlue:CGFloat = CGFloat(arc4random_uniform(256))
        return UIColor(red:   randomRed/255,
                       green: randomGreen/255,
                       blue:  randomBlue/255,
                       alpha: 1.0)
    }
    //Outlet
    @IBOutlet weak var profileImageView: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            self.profileImageView.file = instagramPost["media"] as? PFFile
            profileImageView.layer.borderWidth = 3
            //profileImageView.layer.masksToBounds = true
            
            profileImageView.layer.borderColor = randomColor().cgColor
            //profileImageView.layer.cornerRadius = 3
            self.profileImageView.loadInBackground()
            //profileImageView.clipsToBounds = true
        }
    }
    
}
