//
//  LogInViewController.swift
//  SDU-Groups
//
//  Created by Simone Christensen on 03/12/2019.
//  Copyright © 2019 Borgar Bordoy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {


    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        self.hideKeyboardWhenTappedArround()
        
    }
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Validate the text fields
        
        // Create cleaned versions of text fields
        let email = usernameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                //Couldn't sign in
                print("Sign in failed")
            } else {
                
                let groupViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.groupViewController) as? GroupViewController
                
                self.view.window?.rootViewController = groupViewController
                self.view.window?.makeKeyAndVisible()
                
            }
        }
        
    }
    
    
}

