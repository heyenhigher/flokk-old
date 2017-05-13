//
//  User.swift
//  Flokk
//
//  Created by Gannon Prudhomme on 2/3/17.
//  Copyright © 2017 Flokk. All rights reserved.
//

import Foundation
import UIKit

// A class that represents all user in Flokk.
// There will be a user clas created for the main user(the one that is logged in and using the local app),
//  as well as each user the main user interacts with.
class User: Hashable { // Hashable so it can be used as a key in a dictionary(for comments)
    //var userFIR // The user variable retrieved from Firebase
    var handle: String // A completely unique identifier(ie. @gannonprudhomme)
    //var email: String
    var fullName: String
    var profilePhoto: UIImage
    
    var groups = [Group]() // The groups this user is in
    var groupHandles = [String]() // Passed in from SignIn - for the mainUser
    
    var mainUser: Bool! // Is it the main/local user - not sure if I want this or not.
    
    // Might not need to be loaded immediately
    var friends = [User]() // Array of all friends this user has
    var openFriendRequests = [User]() // Array of users that requested to be this user's friend
    var outgoingFriendRequests = [User]() // Array of users this user requested to be friends wit
    
    init(handle: String, fullName: String) {
        self.handle = handle
        self.fullName = fullName
        self.profilePhoto = UIImage(named: "AddProfilePic")! //temporary
        
        loadPicture()
        // loadFriends() // dont need to load this immediately
    }
    
    init(handle: String, fullName: String, groupHandles: [String]) {
        self.handle = handle
        self.fullName = fullName
        self.profilePhoto = UIImage(named: "AddProfilePic")!
        
        self.groupHandles = groupHandles
    }
    
    init(handle: String, fullName: String, profilePhoto: UIImage) {
        self.handle = handle
        self.fullName = fullName
        self.profilePhoto = profilePhoto
        
        
    }
    
    func loadFriends() {
        
    }
    
    func isFriendsWith(user: User) -> Bool {
        return false
    }
    
    func addNewGroup(group: Group) {
        var json = convertToJSON()
        json["groups"].appendIfArray(json: JSON(group.getFriendlyGroupName()))
        
        FileUtils.saveUserJSON(json: json, user: self)
        
        groups.append(group)
    }
    
    // Call this function if this user(the main user) requests to be friends with another user
    func sendFriendRequestTo(_ user: User) {
        
    }
    
    // Load in this user's profile photo from the database
    // For now just set it manually
    private func loadPicture() {
        
    }
    
    func convertToJSON() -> JSON {
        var json: JSON = [
            "handle": handle,
            "fullName": fullName,
            "profilePhoto": handle + "ProfilePhoto",
            
            "groups": [ ]
        ]
        
        for group in groups {
            json["groups"].appendIfArray(json: JSON(group.getFriendlyGroupName()))
        }
        
        return json
    }
    
    
    // Method needed to implement hashable
    // Used to store and match values in a dictionary
    var hashValue: Int {
        get {
            // As the handles are unique, this value is also unique
            return handle.hashValue
        }
    }
    
    // The func Equatable, needed to implement Hashable
    static func ==(lh: User, rh: User) -> Bool {
        return lh.handle == rh.handle //all handles are unique
    }
    
    // Override the description variable to display information
    // About this class when this class is printed - like Java's .toString() method
    public var description: String {
        return "User: handle: \(handle) full name: \(fullName)"
    }
}

// Determine the various statuses of a friend request
// To determine how to display the add friend button
enum FriendRequestStatus {
    case THIS_USER_SENT
    case THIS_USER_RECEIVED
    case THIS_USER_DENIED
}
