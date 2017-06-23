//
//  SettingsViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/22/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logoutClick(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            var theStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = theStoryBoard.instantiateViewController(withIdentifier: "UserLoginViewController")
            UIApplication.shared.keyWindow?.rootViewController = loginViewController
        }
    }
//    PFUSer.logout()
//    let Login = storyboard.instantiateViewControllerWithIdentifier("someViewController") as! UIViewController
//    self.presentViewController(Login, animated: true, completion: nil)
}
