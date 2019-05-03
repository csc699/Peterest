//
//  CameraProfileViewController.swift
//  Peterest
//
//  Created by Hadia Andar on 4/30/19.
//  Copyright © 2019 Yingying Chen. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user: PFObject!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var bioField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //load user details
        let userName = PFUser.current()?.object(forKey: "username") as! String
        
       let userImage = PFUser.current()?.object(forKey: "profileImage") as! PFFileObject
        let urlString = userImage.url!
        let url = URL(string: urlString)!
        
       let userBio = PFUser.current()?.object(forKey: "userBio") as! String
        
        usernameLabel.text = userName
        imageView.af_setImage(withURL: url)
        bioField.text = userBio

    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        //gets the current users objectId
        let userId = (PFUser.current()?.objectId)!
        
        //this will update the users bio
        let query = PFQuery(className:"_User")
        query.getObjectInBackground(withId: userId) { (object, error) -> Void in
            if object != nil && error == nil {
                print("I was updated!")
                //grabbing the changed image and converting to pffileobject
                let imageData = self.imageView.image!.pngData()
                let file = PFFileObject(data: imageData!)
                object!["profileImage"] = file
                //updating the userBio from the changed bioField input
                object!["userBio"] = self.bioField.text
                object!.saveInBackground()
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print(error)
            }
        }
        
        /* let profile = PFObject(className: "User")
        
        
        profile ["username"] = PFUser.current()!
       // profile ["userBio"] = bioField.text!
        
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        profile ["profileImage"] = file
        
        profile.saveInBackground{ (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error saving post!")
            }
            
        }
 */
    
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
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
