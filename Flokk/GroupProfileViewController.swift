//
//  GroupProfileViewController.swift
//  Flokk
//
//  Created by Jared Heyen on 11/3/16.
//  Copyright © 2016 Flokk. All rights reserved.
//

import UIKit

class GroupProfileViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    var group: Group! // This is just a copy of the actual group
    var notification: Notification? // May not always exist, depending on where we segue from
    
    var oldContentOffset = CGPoint.zero // The previous frame's offset
    var headerConstraintRange: Range<CGFloat>! // The range that determines the min/max of the tableView's expansion/contraction
    var headerViewCriteria = CGFloat(0) // Doesn't actually affect the header view, but used for the scroll view calculations
    
    var invitedReceived = false // If the main user has been invited to this group, by default is false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Create the range for when the tableView should start/stop moving
        self.headerConstraintRange = (CGFloat(self.headerView.frame.origin.y - self.headerView.frame.size.height)..<CGFloat(self.headerView.frame.origin.y))
        self.view.bringSubview(toFront: tableView) // Make sure the table view is always shown on top of the header view
        self.headerViewCriteria = self.headerView.frame.origin.y // Variable that uses the headerView's dimensions but doesn't directly affect it to achieve the desired effect
        
        // Check what data has been loaded for this group that hasn't been loaded already
        // Probably gonna be the members at the least, so do that now 
        if self.group.members.count == 0 {
            for handle in self.group.memberHandles {
                let userRef = database.ref.child("users").child(handle)
                userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    if let values = snapshot.value as? NSDictionary {
                        let fullName = values["fullName"] as! String
                        
                        // Load in the profile photo for this user
                        let profilePhotoRef = storage.ref.child("users").child(handle).child("profilePhoto").child("\(handle).jpg")
                        profilePhotoRef.data(withMaxSize: MAX_PROFILE_PHOTO_SIZE, completion: { (data, error) in
                            if error == nil { // If there wasn't an error
                                let profilePhoto = UIImage(data: data!)
                                
                                let user = User(handle: handle, fullName: fullName, profilePhoto: profilePhoto!)
                                
                                // Attempt to load in the user's friends handles
                                if let friends = values["friends"] as? [String : Bool] {
                                    user.friendHandles = Array(friends.keys)
                                }
                                
                                // Attempt to load in the user's group IDs
                                if let groups = values["groups"] as? [String : Bool] {
                                    user.groupIDs = Array(groups.keys)
                                }
                                
                                // Add the user to the local(specific to the view) group to be displayed
                                self.group.members.append(user)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            } else { // If there was an error
                                print(error!)
                            }
                        })
                    }
                })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backPage(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func requestToJoin(_ sender: AnyObject) {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedSegueGroupProfileContainer" {
            if let groupProfilePageView = segue.destination as? GroupProfilePageViewController {
                groupProfilePageView.group = self.group
            }
        }
    }
}

// Table and Scroll View Functions
extension GroupProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default") as! UserTableViewCell
        
        let user = group.members[indexPath.row]
        
        cell.profilePhotoView.image = user.profilePhoto
        cell.profilePhotoView.layer.cornerRadius = cell.profilePhotoView.frame.size.width / 2
        cell.profilePhotoView.clipsToBounds = true
        
        cell.fullNameLabel.text = user.fullName
        cell.handleLabel.text = "@\(user.handle)"
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        
        // Only scroll the view over the top view when there are enough users to do so
        if self.group.members.count > 4 {
            // Compress the header view
            if delta > 0 && headerViewCriteria > headerConstraintRange.lowerBound && scrollView.contentOffset.y > 0 {
                scrollView.contentOffset.y -= delta
                self.headerViewCriteria -= delta
                
                self.tableView.frame.origin.y -= delta
                self.tableView.frame.size.height += delta
            }
            
            // Expand the header view
            if delta < 0 && headerViewCriteria < headerConstraintRange.upperBound && scrollView.contentOffset.y < 0 {
                scrollView.contentOffset.y -= delta
                self.headerViewCriteria -= delta
                
                self.tableView.frame.origin.y -= delta
                self.tableView.frame.size.height += delta
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
}
