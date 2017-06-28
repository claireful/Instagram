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
        refresh()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        
        // Do any additional setup after loading the view.
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        // ... Create the URLRequest `myRequest` ...
        
        // Configure session so that completion handler is executed on main UI thread
        refresh()
        // ... Use the new data to update the data source ...
        // Reload the tableView now that there is new data
        tableView.reloadData()
            
            // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    func refresh(){
        var query = PFQuery(className: "Post")
        query.includeKey("author")
        query.addDescendingOrder("createdAt")
        query.limit = 20 //hardcoded
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
        
        
        return cell
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
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
