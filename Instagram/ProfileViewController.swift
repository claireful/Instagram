//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Claire Chen on 6/27/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    //Actions
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if let error = error{
                //do nothing
            } else {
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
                print("logout")
            }
        }
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
