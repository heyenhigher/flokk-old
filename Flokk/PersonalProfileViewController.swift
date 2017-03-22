//
//  PersonalProfileViewController.swift
//  Flokk
//
//  Created by Jared Heyen on 3/5/17.
//  Copyright © 2017 Heyen Enterprises. All rights reserved.
//

import UIKit

class PersonalProfileViewController: UIViewController {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!

    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        //this normally won't be here - only for testing
        user = mainUser
        
        profilePic.image = user.profilePhoto
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        profilePic.clipsToBounds = true
        
        username.text = user.handle

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func editProfile(_ sender: Any) {
    }
    @IBOutlet weak var settings: UIButton!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}