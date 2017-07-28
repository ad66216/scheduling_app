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
    var isEditMode: Bool = false
    var appointmentEdit: Appointment!
    
    @IBOutlet weak var tireRotationButton: UIButton!
    @IBOutlet weak var oilChangeButton: UIButton!
    @IBOutlet weak var preventativeMaintenanceButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    var serviceTypedChanged : ((String) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func serviceOfferedDidTap(_ sender: UIButton) {
        
        if isEditMode == false {
            self.appointment = Appointment()
            self.appointment.user = PFUser.current()!
            
            switch sender {
            case tireRotationButton:
                self.appointment.serviceType = "tireRotation"
            case oilChangeButton:
                self.appointment.serviceType = "oilChange"
            case preventativeMaintenanceButton:
                self.appointment.serviceType = "maintenance"
            case otherButton:
                self.appointment.serviceType = "other"
            default:
                return
            }
            self.performSegue(withIdentifier: "servicesOfferedSegue", sender:self)
            
        } else {
            switch sender {
            case tireRotationButton:
                self.appointmentEdit.serviceType = "tireRotation"
//                print(self.appointmentEdit.serviceType)
            case oilChangeButton:
                self.appointmentEdit.serviceType = "oilChange"
            case preventativeMaintenanceButton:
                self.appointmentEdit.serviceType = "maintenance"
            case otherButton:
                self.appointmentEdit.serviceType = "other"
            default:
                return
            }
            let theStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let appointmentDetailViewController = (theStoryBoard.instantiateViewController(withIdentifier: "appointmentDetailViewController") as? AppointmentDetailViewController)!
            appointmentDetailViewController.appointment = appointmentEdit
            
            self.serviceTypedChanged(self.appointmentEdit.serviceType)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DropOffWaitingViewController
        destinationVC.appointment = self.appointment
    }
}












