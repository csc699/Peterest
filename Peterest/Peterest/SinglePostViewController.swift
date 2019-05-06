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
import MessageInputBar

class SinglePostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageInputBarDelegate{
    
    //var comments = [PFObject]()
    
    var posts: PFObject!

    var image = UIImage()
    var username = ""
    var caption = ""
    var imageFile: PFFileObject!
    
    var selectedPost: PFObject!
    
    //variables for message input bar
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        usernameLabel.text = username
        captionLabel.text = caption
        
        //adds the style of the commentBar
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
       
        //assignment of the image file and conversion to url to set the image with alamofireimage
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        imageView.af_setImage(withURL: url)
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.keyboardDismissMode = .interactive
        
        // Do any additional setup after loading the view.
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        //create the comment
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!
        
        //click on comment cell to add comment
        selectedPost.add(comment, forKey: "comments")
         
         selectedPost.saveInBackground { (success, error) in
             if success {
                print("Comment saved")
             } else {
                print("Error saving comment")
             }
         }
        
        tableView.reloadData()
        
        //clear and dismiss the input bar
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = (posts["comments"] as? [PFObject]) ?? []
        //comment bar shows
        if indexPath.row == comment.count {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedPost = posts
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let comment = (posts["comments"] as? [PFObject]) ?? []
        
        return comment.count + 1
    }
    
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count + 1
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let comments = (posts["comments"] as? [PFObject]) ?? []

       
        if indexPath.row < comments.count {
        //grabs the actual values of comments in parse and displays to storyboard
            let comment = comments[indexPath.row]
            cell.commentLabel.text = comment["text"] as? String
            let user = comment["author"] as! PFUser
            cell.usernameLabel.text = user.username
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            return cell

        }
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
