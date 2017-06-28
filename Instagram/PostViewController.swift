//
//  PostViewController.swift
//  Instagram
//
//  Created by Claire Chen on 6/27/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionText: UITextView!

    //Actions
    @IBAction func onPost(_ sender: Any) {
        //send to parse and check error
        print("did click")
        self.performSegue(withIdentifier: "postPostSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
