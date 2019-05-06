//
//  RegisterViewController.swift
//  Peterest
//
//  Created by Stephanie Santana on 4/10/19.
//  Copyright © 2019 Yingying Chen. All rights reserved.
//

import UIKit
import Parse

let user = PFUser()

//global variable for passing in the PFUser
var sharedUser = user

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var backToLogin: UIButton!
    
    @IBAction func onRegister(_ sender: Any) {
        user["fullname"] = nameField.text
        user.username = usernameField.text
        user.email = emailField.text
        // default user bio
        user["userBio"] = "I am generic :) Edit me!"
       
        //grabs the profile placeholder from the assets folder, converts to bytes
        //then is cast to a pffile object
        let image = UIImage(named: "profile_placeholder.png")!
        let imageData = image.pngData()!
        let imageFile = PFFileObject(name:"profile_placeholder.png", data:imageData)
        user["profileImage"] = imageFile
        
        
     
        
        
        
        
     
        //user.saveInBackground()
        
        if(passwordField.text == confirmPasswordField.text){
        user.password = passwordField.text
        } else {
            createAlert(title: "Passwords do not match", message: "Try again?")
        }
        
        user.signUpInBackground() { (success, error) in
            if success {
                self.performSegue(withIdentifier: "backtoLoginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
        //go back to login screen
        self.performSegue(withIdentifier: "backtoLoginSegue", sender: nil)

        }))
    
    self.present(alert, animated: true, completion: nil)
    
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
