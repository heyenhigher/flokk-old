//
//  Database.swift
//  Flokk
//
//  Created by Gannon Prudhomme on 2/17/17.
//  Copyright © 2017 Heyen Enterprises. All rights reserved.
//

import Foundation
import UIKit

//A class that the framework of flokk can use to load data from the database.
//Most of the functions in this class will be static, so a Database object doesn't need to be passed around.
class Database {
    static func loadUserWith(handle: String) -> User {
        //implement later
        return User(handle: "filler", fullName: "Filler Name")
    }
    
    static func getImage() -> UIImage {
        return UIImage()
    }
}