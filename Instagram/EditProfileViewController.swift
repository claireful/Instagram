//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Claire Chen on 6/29/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import ParseUI
import Parse
import RSKPlaceholderTextView

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Outlets
    @IBOutlet weak var profImageView: PFImageView!
    @IBOutlet var placeText: RSKPlaceholderTextView!
    
    //Actions
    @IBAction func onDone(_ sender: Any) {
        //do shit to save
        let curUser = PFUser.current()
        
        let profPic = Post.getPFFileFromImage(image: profImageView.image)
        curUser?.setObject(profPic, forKey: "prof_pic")
        curUser?.setObject(placeText.text, forKey: "description")
        curUser?.saveInBackground(block: { (success: Bool, error: Error?) in
            if success {
                self.dismiss(animated: true, completion: { 
                    //saveddddd
                })
            }
        })
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true) { 
            //done
        }
    }
    
    
    @IBAction func onTake(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .camera
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func onChoose(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        profImageView.image = editedImage
        
        // Do something with the images (based on your use case)
        //go to postViewController
        
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let curUser = PFUser.current()
        profImageView.file = curUser?.object(forKey: "prof_pic") as? PFFile
        profImageView.loadInBackground()
        //PFUser.current()?.object(forKey: "description") as? String
        // Do any additional setup after loading the view.
        //placeholder
        self.placeText = RSKPlaceholderTextView(frame: CGRect(x: 16 , y: 353, width: self.view.frame.width-32, height: 100))
        self.placeText.placeholder = curUser?.object(forKey:
            "description") as! String as NSString
        
        self.view.addSubview(self.placeText)
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
