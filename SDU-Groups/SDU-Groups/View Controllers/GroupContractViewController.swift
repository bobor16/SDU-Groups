//
//  GroupContractViewController.swift
//  SDU-Groups
//
//  Created by Simone Christensen on 26/11/2019.
//  Copyright © 2019 Borgar Bordoy. All rights reserved.
//

import UIKit
import Firebase

class GroupContractViewController: UIViewController{

    @IBOutlet weak var textField: UITextView!
    
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedArround()
        ref = Database.database().reference()
    
    }
    
    
    @IBAction func uploadToDatabase(_ sender: UIButton) {
        let event = textField.text
        ref?.child("Events").setValue(event)
        NSLog("Uploading...")
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
