//
//  GroupContractViewController.swift
//  SDU-Groups
//
//  Created by Simone Christensen on 26/11/2019.
//  Copyright © 2019 Borgar Bordoy. All rights reserved.
//

import UIKit


class GroupContractViewController: UIViewController{

    @IBOutlet weak var inputKeyTextField: UITextField!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var uploadContract: UIButton!
    @IBOutlet weak var getContract: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedArround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadToDatabase(_ sender: UIButton) {
        Constants.ref.db.collection(inputKeyTextField.text!).document("Contract").setData(["User":Constants.cUser.username!.email!, "Contract":textField.text!])
    }
    
    @IBAction func getContractFromDatabase(_ sender: UIButton) {
        Constants.ref.db.collection(inputKeyTextField.text!).document("Contract").getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    }
                }
            }
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
