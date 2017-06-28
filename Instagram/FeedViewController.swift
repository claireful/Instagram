//
//  FeedViewController.swift
//  Instagram
//
//  Created by Claire Chen on 6/28/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    //Variables
    var posts: [PFObject]?
    
    //Outlet
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        print("before ref")
        refresh()
        print("after ref")
        
        
        // Do any additional setup after loading the view.
    }
    
    func refresh(){
        var query = PFQuery(className: "Post")
        query.includeKey("author")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if error == nil {
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print(error)
            }

        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts![indexPath.row]
        if let user = post["author"] as? PFUser{
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "Guest 💩"
        }
        //let user = post["author"] as? PFUser
        //et username = user?.username
        //cell.usernameLabel.text = username
        
        cell.captionLabel.text = post["caption"] as! String
        cell.instagramPost = post //set PFObject to be accessed in post cell
        
        
        
        var count: Int = 0
        for post in posts!{
            count+=1
            print(count)
            print(post["caption"])
        }
        return cell
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
