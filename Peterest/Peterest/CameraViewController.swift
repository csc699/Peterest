//
//  CameraViewController.swift
//  Peterest
//
//  Created by Stephanie Santana on 4/17/19.
//  Copyright © 2019 Yingying Chen. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var captionField: UITextField!
    
    
    @IBAction func cancelPost(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submitPost(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["author"] = PFUser.current()!
        post["caption"] = captionField.text!
        
        let imagePlaceholder = UIImage(named: "image_placeholder")
        if (imageView.image == imagePlaceholder) {
            print("you need a real image")
            createAlert(title: "You need to select an image", message: "Try again?")
            } else {
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        post.saveInBackground { (success, error) in
                if success {
                    print("saved")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("error in saving post")
                }
            }
        }
    
        
    }
    
    //creates an alert when the user trys to submit post without photo
    func createAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //creation of button
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("yes")
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("no")
            //closes the window because user chose no
            self.cancelPost(PFUser.current())
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
    
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
