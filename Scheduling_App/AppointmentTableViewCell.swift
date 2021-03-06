//
//  AppointmentTableViewCell.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/14/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation
import Parse

class AppointmentTableViewCell : UITableViewCell {
    
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var apptDateTime: UILabel!
    @IBOutlet weak var apptVehicle: UILabel!
    @IBOutlet weak var apptStatus: UILabel!
    @IBOutlet weak var apptType: UILabel!
    
    public var appointment: Appointment? {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let a = appointment else {
            return
        }
        
        let monthName = Utils.getMonthName(month: a.month)
        let apptHour = Utils.formatHourFromMinutes(minutes: a.time)
        
        let apptMin = Utils.getApptMinutes(minutes: a.time % 60)
        let apptAmOrPm = Utils.getAmOrPm(minutes: a.time)
        let apptTime = "\(apptHour):\(apptMin)\(apptAmOrPm)"
        let dateTimeText = "\(a.dayOfWeek), \(monthName) \(a.date), \(a.year) @ \(apptTime)"
        
        self.serviceType.text = Utils.convertServiceType(type: a.serviceType)
        self.apptType.text = Utils.convertApptType(type: a.appointmentType)
        self.apptDateTime.text = dateTimeText
        
        if appointment?.vehicle == nil {
            self.apptVehicle.text = ""
        } else {
            self.apptVehicle.text = Utils.getVehicleInfo(vehicle: (appointment?.vehicle)!)
        }
        
        if appointment?.tracking.appointmentStatus == nil {
            
            self.apptStatus.text = ""
        } else {
            guard let status = appointment?.tracking.appointmentStatus.name else {
                return
            }
            self.apptStatus.text = "Status: \(status)"
        }
    }
}



























