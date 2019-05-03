//
//  SearchViewController.swift
//  Peterest
//
//  Created by Russelle Pineda on 4/14/19.
//  Copyright © 2019 Yingying Chen. All rights reserved.
//

import UIKit
import Parse

class FriendProfileViewController: UIViewController {
    
    var user: PFObject!
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.        
        let userName = user.object(forKey: "fullname") as! String
        let userImage = user.object(forKey: "profileImage") as! PFFileObject
        let urlString = userImage.url!
        let url = URL(string: urlString)!
        
        usernameLabel.text = userName
        profilePic.af_setImage(withURL: url)
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
