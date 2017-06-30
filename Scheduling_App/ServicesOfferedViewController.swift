//
//  ServicesOfferedViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 5/18/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse

class ServicesOfferedViewController: UIViewController {

    var appointment: Appointment!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func unwindFromOilChange(segue: UIStoryboardSegue) {
//        
//    }
    
    @IBAction func tireRotationClick(_ sender: Any) {
        self.appointment = Appointment()
        //let user = PFUser()
        self.appointment.user = PFUser.current()!
        self.appointment.serviceType = "tireRotation"
        self.performSegue(withIdentifier: "tireRotationSegue", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DropOffWaitingViewController
        destinationVC.appointment = self.appointment
    }
}












