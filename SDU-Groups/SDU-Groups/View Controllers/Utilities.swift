//
//  Utilities.swift
//  SDU-Groups
//
//  Created by Simone Christensen on 03/12/2019.
//  Copyright © 2019 Borgar Bordoy. All rights reserved.
//
import Foundation
import UIKit

class Utilities {

    static func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }

}
