//
//  GroupViewController.swift
//  SDU-Groups
//
//  Created by Simone Christensen on 05/10/2019.
//  Copyright © 2019 Borgar Bordoy. All rights reserved.
//

import UIKit


class GroupViewController: UIViewController{
    
    func openURL(urlSt: String!) {
        if let url = URL(string:urlSt), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openURL2(url2: String) {
        if let url = URL(string: url2) {
            do {
                let contents = try String(contentsOf: url)
                print(contents)
            } catch {
                
            }
        } else {
            print("Bad url")
        }
    }

    
    
    @IBAction func bookRoomBtn(_ sender: UIButton) {
        if let url = URL(string: "https://www.hackingwithswift.com") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func myBookings(_ sender: UIButton) {
        print("GG")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
    }
    
    
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

