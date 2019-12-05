//
//  Constants.swift
//  SDU-Groups
//
//  Created by Simone Christensen on 03/12/2019.
//  Copyright © 2019 Borgar Bordoy. All rights reserved.
//

import Foundation
import Firebase

struct Constants {
    
    struct Storyboard {
        static let groupViewController = "groupVC"
    }
    struct ref {
        static let db = Firestore.firestore()
    }
    
    struct cUser {
        static let username = Auth.auth().currentUser
    }
    
    
}
