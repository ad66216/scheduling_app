//
//  AppointmentDetailViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/21/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit

class AppointmentDetailViewController: UIViewController {

    @IBOutlet weak var apptTypeLabel: UILabel!
    @IBOutlet weak var apptDateLabel: UILabel!
    @IBOutlet weak var apptVehicleLabel: UILabel!
    @IBOutlet weak var apptStatusLabel: UILabel!
    
    var appointment: Appointment!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.apptTypeLabel.text = Utils.convertServiceType(type: appointment.serviceType)
        let monthName = Utils.getMonthName(month: appointment.month)
        let apptHour = Utils.formatHourFromMinutes(minutes: appointment.time)
        
        let apptMin = Utils.getApptMinutes(minutes: appointment.time % 60)
        let apptAmOrPm = Utils.getAmOrPm(minutes: appointment.time)
        let apptTime = "\(apptHour):\(apptMin)\(apptAmOrPm)"
        let dateTimeText = "\(appointment.dayOfWeek), \(monthName) \(appointment.date), \(appointment.year) @ \(apptTime)"
        
        self.apptDateLabel.text = dateTimeText
        
        apptVehicleLabel.text = Utils.getVehicleInfo(vehicle: appointment.vehicle)
        
        if appointment?.appointmentStatus == nil {
            
            self.apptStatusLabel.text = ""
        } else {
            guard let status = appointment?.appointmentStatus.name else {
                return
            }
            self.apptStatusLabel.text = status
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
