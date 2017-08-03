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

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserLoginViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (PFUser.current() != nil) {
            self.performSegue(withIdentifier: "MainTabBarSegue", sender:self)
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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























