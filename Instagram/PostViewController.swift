//
//  PostViewController.swift
//  Instagram
//
//  Created by Claire Chen on 6/27/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class PostViewController: UIViewController {
    //Variable
    var post: UIImage? = nil
    
    
    //Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet var captionText: RSKPlaceholderTextView!
    

    //Actions
    @IBAction func onPost(_ sender: Any) {
        //send to parse and check error
        post = resize(image: post!, newSize: CGSize(width: 750, height: 750))
        Post.postUserImage(image: post, withCaption: captionText.text) { (bool: Bool, error: Error?) in
            if error != nil {
                print(error?.localizedDescription ?? "ERROR")
                //do nothing
            } else {
                print("successfully posted")
                self.performSegue(withIdentifier: "postPostSegue", sender: nil)
            }
        }
        //self.performSegue(withIdentifier: "postPostSegue", sender: nil)
    }
    
    //Actions
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if post != nil {
            postImageView.image = post
        } else {
            print("something went wrong")
        }
        // Do any additional setup after loading the view.
        //placeholder
        self.captionText = RSKPlaceholderTextView(frame: CGRect(x: 16 , y: 73, width: 253, height: 162))
        self.captionText.placeholder = "Write a Caption"
        self.view.addSubview(self.captionText)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
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
