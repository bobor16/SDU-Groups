//
//  SettingsViewController.swift
//  SDU-Groups
//
//  Created by Simone Christensen on 05/12/2019.
//  Copyright © 2019 Borgar Bordoy. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        
        if let storyboard  = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
            self.present(vc, animated: false, completion: nil)
        }
        
    }
    

}
