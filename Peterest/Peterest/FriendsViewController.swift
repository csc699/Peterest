//
//  FriendsViewController.swift
//  Peterest
//
//  Created by Yingying Chen on 4/8/19.
//  Copyright © 2019 Yingying Chen. All rights reserved.
//

import UIKit
import Parse

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var friends = [PFObject]()
    
    var friendArr = [String]()
    var searchFriend = [String]()
    var searching = false

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFUser.query()
        query?.includeKey("username")
        query?.limit = 20
        
        query?.findObjectsInBackground { (friends, error) in
            if friends != nil {
                self.friends = friends!
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchFriend.count
        } else {
            return friends.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell") as! FriendsCell
        
        if searching {
            cell.usernameLabel.text = searchFriend[indexPath.row]
        } else {
            let friend = friends[indexPath.row]
            cell.usernameLabel.text = friend["fullname"] as! String
            if (friends.count > friendArr.count) {
                friendArr.append(friend["fullname"] as! String)
            }
        }
  
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let user = friends[indexPath.row]
        
        let friendProfileViewController = segue.destination as! FriendProfileViewController
        friendProfileViewController.user = user
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        
    }

}

extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFriend = friendArr.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
}
