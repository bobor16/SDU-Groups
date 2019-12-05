//
//  CreateUserViewController.swift
//  SDU-Groups
//
//  Created by Simone Christensen on 03/12/2019.
//  Copyright © 2019 Borgar Bordoy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore



class CreateUserViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var newUsername: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedArround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    //Check the fields and validate that the data is correct.
    //If everything is correct, this method retuns nil. Otherwise
    //it returns the error message.
    func validateFields() -> String? {
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            newUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || newPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        // check if the password is secure
        let cleanedPassword = newPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        // It is possible to do the same for the email format, remember
        //to add it to the Utilities.swift as well
        return nil
    }
    @IBAction func createTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            // There's something wrong with the fields, show error message
            displayError(error!)
        } else {
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = newUsername.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = newPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    
                    self.displayError("Error creating user")
                    
                } else {
                    
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                        //Show error message
                        self.displayError("Error saving user data")
                        }
                    }
                    //Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func displayError(_ message:String) {
        
        print("There's something wrong with the fields")
    }
    func transitionToHome() {
        let groupViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.groupViewController) as? GroupViewController
        
        view.window?.rootViewController = groupViewController
        view.window?.makeKeyAndVisible()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
    
    


