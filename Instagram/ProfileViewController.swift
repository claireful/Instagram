//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Claire Chen on 6/27/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDataSource {
    //Variables
    var posts: [PFObject]?
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    
    
    //Actions
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if let error = error{
                //do nothing
            } else {
                self.dismiss(animated: true, completion: {
                    print("logout")
                })
            }
        }
    }
    
    @IBAction func onEdit(_ sender: Any) {
        performSegue(withIdentifier: "editSegue", sender: nil)
    }
    
    
    func refreshForUser(){
        //TODO sort only with current user
        let query = PFQuery(className: "Post")
        query.whereKey("author", equalTo: PFUser.current())
        query.includeKey("author")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if error == nil {
                self.posts = posts
                self.collectionView.reloadData()
            } else {
                print(error ?? "ERROR")
            }
            
        }
        
    }
    
    //data source methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotoCell", for: indexPath) as! ProfilePhotoCell
        let post = posts?[indexPath.item]
        cell.instagramPost = post //set PFObject to be accessed in post cell
        return cell
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        let curUser = PFUser.current()
        usernameLabel.text = curUser?.username
        refreshForUser()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileDetailsSegue"{
            let vc = segue.destination as! PostDetailsViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)!
            let post = posts?[indexPath.item]
            //print(indexPath.row)
            vc.post = post
            //            vc.user = PFUser.current()
            
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }
        
        
    }
}
