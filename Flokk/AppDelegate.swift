//
//  AppDelegate.swift
//  Tutorial
//
//  Created by Jared Heyen on 10/7/16.
//  Copyright © 2016 Flokk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var mainUser: User!
var database: Database!
var storage: Storage!
var groups = [Group]() // Should i do groups like this so they only need to be loaded once?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Use Firebase library to configure APIs
        database = Database()
        storage = Storage()
        
        //FIRApp.configure()
        
        //database.createNewUser(email: "gannonprudhomme@gmail.com", password: "gannon123", handle: "gannonprudhomme", fullName: "Gannon Prudhomme", profilePhoto: UIImage())
        
        // Retrieve a registration token for this client
        let token = FIRInstanceID.instanceID().token()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    //remove all the stored files
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
