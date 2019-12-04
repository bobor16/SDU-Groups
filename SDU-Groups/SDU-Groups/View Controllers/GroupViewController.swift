//
//  GroupViewController.swift
//  SDU-Groups
//
//  Created by Simone Christensen on 05/10/2019.
//  Copyright © 2019 Borgar Bordoy. All rights reserved.
//

import UIKit


class GroupViewController: UIViewController{
    
    @IBAction func Schedule(_ sender: UIButton) {
        guard let url = URL(string: "https://mitsdu.sdu.dk/skema/default.aspx") else {
            return
        }
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func BookRoom(_ sender: UIButton) {
        guard let url = URL(string: "https://mitsdu.sdu.dk/booking/default.aspx") else {
            return
        }
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}
