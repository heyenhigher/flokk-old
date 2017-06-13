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
    var handle: String // A completely unique identifier(ie. @gannonprudhomme)
    var fullName: String
    var profilePhoto: UIImage
    var email: String! // The email of this user, usually not going to be generated
    
    var groups = [Group]() // The groups this user is in
    var groupIDs = [String]() // The IDs of all the groups this user is in
    
    var friends = [User]() // Array of all friends this user has that have already been loaded
    var friendHandles = [String]() // Array of the handles of friends this user has, don't need all of the user's data the entire time
    
    var incomingFriendRequests = [String]() // Array of user handles that requested to be this user's friend
    var outgoingFriendRequests = [String]() // Array of user handles this user requested to be friends with
    
    var groupInvites: [String]! // Array of ID's for the group the user has been invited to
    
    var notifications = [Notification]() // The user's notifications
    
    init(handle: String, fullName: String) {
        self.handle = handle
        self.fullName = fullName
        self.profilePhoto = UIImage(named: "AddProfilePic")! //temporary
        
        loadPicture()
    }
    
    init(handle: String, profilePhoto: UIImage) {
        self.handle = handle
        self.profilePhoto = profilePhoto
        self.fullName = ""
    }
    
    init(handle: String, fullName: String, groupIDs: [String]) {
        self.handle = handle
        self.fullName = fullName
        self.profilePhoto = UIImage(named: "AddProfilePic")!
        
        self.groupIDs = groupIDs
    }
    
    init(handle: String, fullName: String, profilePhoto: UIImage) {
        self.handle = handle
        self.fullName = fullName
        self.profilePhoto = profilePhoto
    }
    
    init(handle: String, fullName: String, profilePhoto: UIImage, groupIDs: [String]) {
        self.handle = handle
        self.fullName = fullName
        self.profilePhoto = profilePhoto
        
        self.groupIDs = groupIDs
    }
    
    func loadFriends() {
        
    }
    
    func isFriendsWith(user: User) -> Bool {
        return false
    }
    
    // Call this function if this user(the main user) requests to be friends with another user
    func sendFriendRequestTo(_ user: User) {
        
    }
    
    // Load in this user's profile photo from the database
    // For now just set it manually
    private func loadPicture() {
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
