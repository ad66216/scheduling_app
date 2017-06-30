//
//  DropOffWaitingViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/30/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse

class DropOffWaitingViewController: UIViewController {

    var appointment: Appointment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dropOffClick(_ sender: Any) {
        self.appointment.appointmentType = "dropOff"
        //self.performSegue(withIdentifier: "dropOffSegue", sender:self)
    }
    
    @IBAction func waitingInStoreClick(_ sender: Any) {
        self.appointment.appointmentType = "waiting"
        //self.performSegue(withIdentifier: "waitingInStoreSegue", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ScheduleViewController
        destinationVC.appointment = self.appointment
    }
}







