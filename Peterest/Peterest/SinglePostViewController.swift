//
//  SinglePostViewController.swift
//  Peterest
//
//  Created by Stephanie Santana on 5/4/19.
//  Copyright © 2019 Yingying Chen. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class SinglePostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var comments = [PFObject]()
    
    var posts = [PFObject]()

    var image = UIImage()
    var username = ""
    var caption = ""
    var imageFile: PFFileObject!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        usernameLabel.text = username
        captionLabel.text = caption
       
        //assignment of the image file and conversion to url to set the image with alamofireimage
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        imageView.af_setImage(withURL: url)
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        
        //creates our first comment in parse database
        let comment = PFObject(className: "Comments")
        comment["text"] = "Why you no working?"
        comment["post"] = post
        comment["author"] = PFUser.current()!
        
        //click on comment cell to add comment
        /*post.add(comment, forKey: "comments")
        
        post.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error saving comment")
            }
        }*/
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comment = (post["comments"] as? [PFObject]) ?? []
        
        return comment.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        
        //test data that prints the current user logged in and a test comment
        //cell.usernameLabel.text = PFUser.current()!.username
        //cell.commentLabel.text = "This is so cute!"
        
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []

        //grabs the actual values of comments in parse and displays to storyboard
        let comment = comments[indexPath.row]
        cell.commentLabel.text = comment["text"] as? String
        let user = comment["author"] as! PFUser
        cell.usernameLabel.text = user.username
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
