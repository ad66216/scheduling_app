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
    var isEditMode: Bool = false
    var appointmentEdit: Appointment!
    
    @IBOutlet weak var dropOffButton: UIButton!
    @IBOutlet weak var waitingButton: UIButton!
    
    var apptTypeChanged : ((String) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func dropOffWaitingDidTap(_ sender: UIButton) {
        
        if isEditMode == false {
            switch sender {
            case dropOffButton:
                self.appointment.appointmentType = "dropOff"
            case waitingButton:
                self.appointment.appointmentType = "waiting"
            default:
                return
            }
            self.performSegue(withIdentifier: "dropOffWaitingSegue", sender:self)
        } else {
            switch sender {
            case dropOffButton:
                self.appointmentEdit.appointmentType = "dropOff"
            case waitingButton:
                self.appointmentEdit.appointmentType = "waiting"
            default:
                return
            }
            let theStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let dropOffWaitingViewController = (theStoryBoard.instantiateViewController(withIdentifier: "dropOffWaitingViewController") as? DropOffWaitingViewController)!
            dropOffWaitingViewController.appointment = appointmentEdit
            
            self.apptTypeChanged(self.appointmentEdit.appointmentType)
            self.navigationController?.popViewController(animated: true)
        }
    }

//    @IBAction func dropOffClick(_ sender: Any) {
//        self.appointment.appointmentType = "dropOff"
//        //self.performSegue(withIdentifier: "dropOffSegue", sender:self)
//    }
//    
//    @IBAction func waitingInStoreClick(_ sender: Any) {
//        self.appointment.appointmentType = "waiting"
//        //self.performSegue(withIdentifier: "waitingInStoreSegue", sender:self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ScheduleViewController
        destinationVC.appointment = self.appointment
    }
}







