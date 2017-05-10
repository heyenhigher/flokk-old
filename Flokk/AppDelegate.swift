//
//  AppDelegate.swift
//  Tutorial
//
//  Created by Jared Heyen on 10/7/16.
//  Copyright © 2016 Flokk. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

// Universal Variables for testing
var mainUser = User(handle: "gannonprudhomme", fullName: "Gannon Prudhomme")
var jaredUser = User(handle: "jaredheyen", fullName: "Jared Heyen")
var tavianUser = User(handle: "taviansims", fullName: "Tavian Sims")
var crosbyUser = User(handle: "crosbus", fullName: "Crosby Busfield")
var grantUser = User(handle: "granthuser", fullName: "Grant Huser")
var ryanUser = User(handle: "ryanmac", fullName: "Ryan McClemore")
var berginUser = User(handle: "berginelias", fullName: "Bergin Elias")
var alexUser = User(handle: "alexshilnikov", fullName: "Alex Shilnikov")
var chandlerUser = User(handle: "chanfranks", fullName: "Chandler Franks")
var madiUser = User(handle: "madileal", fullName: "Madi Leal")
var lucasUser = User(handle: "lucasarnold", fullName: "Lucas Arnold")

var friendGroup = Group(groupName: "Friends", image: UIImage(named: "groupPhoto")!, users: [mainUser, jaredUser, tavianUser, crosbyUser, grantUser, ryanUser, berginUser, alexUser, chandlerUser, madiUser, lucasUser], creator: mainUser)
var otherGroup = Group(groupName: "Other", image: UIImage(named: "group2Photo")!, users: [jaredUser, tavianUser, lucasUser, madiUser, berginUser], creator: mainUser)
var group1 = Group(groupName: "Group1", image: UIImage(named: "groupPhoto")!, users: [jaredUser, mainUser], creator: mainUser)
var group2 = Group(groupName: "Group2", image: UIImage(named: "groupPhoto")!, users: [jaredUser, mainUser], creator: mainUser)
var group3 = Group(groupName: "Group3", image: UIImage(named: "groupPhoto")!, users: [jaredUser, mainUser], creator: mainUser)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Use Firebase library to configure APIs
        FIRApp.configure()
        
        // Register for remote app notifications
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
            
            // For iOS 10 data message (sent via FCM)
            FIRMessaging.messaging().remoteMessageDelegate = self
            
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
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
    
    func loadUserTestData() {
        // Make all the users be apart of the groups
        crosbyUser.groups.append(friendGroup)
        tavianUser.groups.append(friendGroup)
        grantUser.groups.append(friendGroup)
        ryanUser.groups.append(friendGroup)
        berginUser.groups.append(friendGroup)
        alexUser.groups.append(friendGroup)
        chandlerUser.groups.append(friendGroup)
        madiUser.groups.append(friendGroup)
        lucasUser.groups.append(friendGroup)
        jaredUser.groups.append(group1)
        jaredUser.groups.append(group2)
        jaredUser.groups.append(group3)
        jaredUser.groups.append(group1)
        jaredUser.groups.append(group2)
        jaredUser.groups.append(group3)
    }
}
