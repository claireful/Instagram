//
//  LoginViewController.swift
//  Instagram
//
//  Created by Claire Chen on 6/27/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //Actions
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                self.usernameField.text = ""
                self.passwordField.text = ""
                print("Logged In")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            } else {
                self.showAlert()
            }
        }
    }
    
    
    
    @IBAction func onSIgnUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
            
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                let defaultIcon = Post.getPFFileFromImage(image: (UIImage(named: "user_icon")))
                newUser.setObject(defaultIcon, forKey: "prof_pic")
                newUser.setObject("im a fub", forKey: "description")
                newUser.saveInBackground(block: { (sucess: Bool, error:Error?) in
                    if (sucess != nil) {
                        print("eyyyyyyyyy saveddddd")
                    } else {
                        print("boo")
                    }
                })
                print("Sign Up Successful!")
                self.usernameField.text = ""
                self.passwordField.text = ""
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            } else {
                self.showAlert()
                print(error?.localizedDescription ?? "Error")
            }

        }
        
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func showAlert(){
        let alertController = UIAlertController(title: "Error", message: "Did not enter username or password correctly.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            //handle response here
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true){
            //optional code for what happens after the alert controller has finished presenting
        }
        
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
