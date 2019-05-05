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

class SinglePostViewController: UIViewController {
    
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

        // Do any additional setup after loading the view.
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
