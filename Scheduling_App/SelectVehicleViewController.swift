//
//  SelectVehicleViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/7/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse

class SelectVehicleViewController: VehicleListViewController {
    
    var appointment: Appointment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func didSelectVehicle(_ vehicle: Vehicle) {
        // show a dialog asking to confirm the appointment
        
        if self.appointment == nil {
            
            print("appointment is nil")
            
        } else {
            
            self.appointment.vehicle = vehicle
            
            let refreshAlert = UIAlertController(title: "Are you sure?", message: "Are you sure you wish to create this appointment?", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action: UIAlertAction!) in
                
                self.appointment.saveInBackground(block: { (succeeded: Bool?, error: Error?) -> Void in
                    if error != nil {
                        print("The getFirstObject request failed.")
                    } else {
                        let time = Utils.convertMinutesToDateString(minutes: Double(self.appointment.time))
                        let monthName = Utils.getMonthName(month: self.appointment.month)
                        let alert = UIAlertController(title: "Success", message: "Your appointment is scheduled for \(self.appointment.dayOfWeek) \(monthName) \(self.appointment.date), \(self.appointment.year) at \(time)", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        // number of seconds in delay (in this case 5 seconds)
                        let when = DispatchTime.now() + 5
                        DispatchQueue.main.asyncAfter(deadline: when){
                            // code with delay
                            alert.dismiss(animated: true, completion: nil)
                            self.performSegue(withIdentifier: "unwindSegueToAppt", sender: self)
                        }
                    }
                })
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
}



















