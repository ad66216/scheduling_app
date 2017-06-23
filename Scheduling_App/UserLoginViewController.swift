//
//  UserLoginViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/22/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse

class UserLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (PFUser.current() != nil) {
            self.performSegue(withIdentifier: "MainTabBarSegue", sender:self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInClick(_ sender: Any) {
        self.verifyUser()
    }
    
    func verifyUser() {
        PFUser.logInWithUsername(inBackground: self.emailTextField.text!, password:self.passwordTextField.text!) {
            (user: PFUser?, error: Error?) -> Void in
            if let error = error {
                if let errorString = (error as NSError).userInfo["error"] as? String {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = errorString
                }
            } else {
                // Hooray! Let them use the app now.
                NSLog("Logged in!")
                self.performSegue(withIdentifier: "MainTabBarSegue", sender:self)
            }
        }
    }
}























