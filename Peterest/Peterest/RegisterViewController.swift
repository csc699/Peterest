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
        user.password = passwordField.text
        user.password = confirmPasswordField.text
        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
