//
//  Post.swift
//  Flokk
//
//  Created by Gannon Prudhomme on 2/3/17.
//  Copyright © 2017 Flokk. All rights reserved.
//

import Foundation
import UIKit

// A class that represents each indivual image post in a group's feed.
// This class will contain all of a posts likes, the image itself, and all of the comments on it.
class Post {
    var poster: User! // The user who posted the image
    var posterHandle: String! // The Handle of the user who posted the image, no need to retrieve user data we're not going to use
    var image: UIImage // The image posted
    
    var comments = [Comment]() // Holds all the comments, hopefully stored in order
    var timePosted: NSDate! // The time this post was originally uploaded
    var index: Int! // Represents this posts position in the post array from the group
    var id: String! // The ID generated by childByAutoID when this was first posted
    
    
    init(poster: User, image: UIImage, postID: String) {
        self.poster = poster
        self.image = image
        self.id = postID
        //self.postedGroup = postedGroup
    }
    
    init(posterHandle: String, image: UIImage, postID: String) {
        self.posterHandle = posterHandle
        self.image = image
        self.id = postID
    }
    
    /*
    //find the user from the participants in this group just by using their handle
    //when we have the database we can reduce storage by getting this frk
    //this should be in the Group class anyways
    func findUserInGroupWith(handle: String) -> User {
        for user in postedGroup.members {
            if user.handle == handle {
                return user
            }
        }
        
        print("user with handle \(handle) is not listed in the participants group")
        return User(handle: "nil", fullName: "Nil Nil")
    }
    
    // Override the description variable to display information
    // About this class when this class is printed - like Java's .toString() method
    public var description: String {
        return "Posted by: (\(poster.description)) in group: (\(postedGroup.groupName)) at index: (\(index))"
    } */
}

// A class that holds the values for comments on Posts
// I'm not happy this has to be a separate class lol
class Comment {
    var user: User // The user who posted the comment
    var content: String // The text of the comment
    var date: Date
    
    init(user: User, content: String) {
        self.user = user
        self.content = content
        self.date = Date() //later this needs to be loaded alongside the rest of the data, not created here
    }
}
