//
//  OpenViewController.swift
//  Flokk
//
//  Created by Jared Heyen on 3/3/17.
//  Copyright © 2017 Heyen Enterprises. All rights reserved.
//

import UIKit

class OpenViewController: UIViewController {
    @IBOutlet weak var flokkLogo: UIImageView!

    let transitionForward = SlideForwardAnimator(right: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signUpBttn(_ sender: Any) {
    }
    @IBAction func signInPageBttn(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //it doesnt matter whether we segue to sign up or sign in
        //we will use the same transition
        
    }
}