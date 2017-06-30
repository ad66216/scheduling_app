//
//  CreateAccountViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/22/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccoutClick(_ sender: Any) {
        self.signUpUser()
    }
    
    func signUpUser() {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user["firstName"] = firstNameTextField.text
        user["lastName"] = lastNameTextField.text
        
        user.signUpInBackground { (succeeded: Bool, error: Error?) in
            if (error != nil) {
                
                let errorString = error as? NSString
                 //Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
            
        }
        
//        user.signUpInBackgroundWithBlock {
//            (succeeded: Bool, error: NSError?) -> Void in
//            if let error = error {
//                let errorString = error.userInfo["error"] as? NSString
//                // Show the errorString somewhere and let the user try again.
//            } else {
//                // Hooray! Let them use the app now.
//            }
//        }
    }

}
