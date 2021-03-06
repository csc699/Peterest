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

protocol UpdateDelegate {
    func didUpdate (name: String, bio: String, image: UIImage)
}

class CameraProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioField: UITextField!
    
    var finalImage: UIImage!
    var finalUsername: String!
    var finalBio: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load user details
        imageView.image = finalImage
        usernameLabel.text = finalUsername
        bioField.text = finalBio
        
    }
    
    var delegate: UpdateDelegate?
    
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
                if self.delegate != nil {
                    //this updates profile VC
                    self.delegate?.didUpdate(name: self.usernameLabel.text!, bio: self.bioField.text!, image: self.imageView.image!)
                    //dismiss the model
                    self.dismiss(animated: true, completion: nil)
                }
                
            } else {
                print(error)
            }
        }
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
