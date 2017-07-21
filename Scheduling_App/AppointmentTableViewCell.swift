//
//  AppointmentTableViewCell.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/14/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation

class AppointmentTableViewCell : UITableViewCell {
    
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var apptDateTime: UILabel!
    @IBOutlet weak var apptVehicle: UILabel!
    @IBOutlet weak var apptStatus: UILabel!
    
    public var appointment: Appointment? {
        didSet {
            layoutSubviews()
        }
    }
    
//    open override var height: CGFloat {
//        get {
//            return appointmentViewCell.height
//        }
//        set(value) {
//            super.height = value
//        }
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let a = appointment else {
            return
        }
        
        let monthName = Utils.getMonthName(month: a.month)
        var apptHour: Int = 0
        
        if a.time < 60 {
            apptHour = 12
        } else {
            if a.time > 720 {
                apptHour = (a.time/60) - 12
            } else {
                apptHour = a.time/60
            }
        }
        let apptMin = Utils.getApptMinutes(minutes: a.time % 60)
        let apptAmOrPm = Utils.getAmOrPm(minutes: a.time)
        let apptTime = "\(apptHour):\(apptMin)\(apptAmOrPm)"
        let dateTimeText = "\(a.dayOfWeek), \(monthName) \(a.date), \(a.year) @ \(apptTime)"
        
        self.serviceType.text = Utils.convertServiceType(type: a.serviceType)
        self.apptDateTime.text = dateTimeText
//        self.apptDateTime.text = a.appointmentStatus
//        self.apptDateTime.text = apptStatus.name

//        let vehicleString: String = "\(String(describing: appointment?.vehicle.make)) \(String(describing: appointment?.vehicle.model))"
//        self.apptVehicle.text = "\(appointment?.vehicle.make) \(appointment?.vehicle.model)"
//        self.apptVehicle.text = appointment?.vehicle.make
        
        if appointment?.vehicle == nil {
            self.apptVehicle.text = ""
        } else {
            
            var vehicleText = ""
            
            if let vehicleYear = appointment?.vehicle.year {
                vehicleText += "\(vehicleYear)"
            }
            if let vehicleMake = appointment?.vehicle.make {
                
                if (vehicleText != "") {
                    vehicleText += " "
                }
                vehicleText += vehicleMake
            }
            if let vehicleModel = appointment?.vehicle.model {
                
                if (vehicleText != "") {
                    vehicleText += " "
                }
                vehicleText += vehicleModel
            }
            if let vehicleColor = appointment?.vehicle.color {
                
                if (vehicleText != "") {
                    vehicleText += " - "
                }
                vehicleText += vehicleColor
            }
//            self.apptVehicle.text = "\(vehicleYear) \(vehicleMake) \(vehicleModel) - \(vehicleColor)"
            self.apptVehicle.text = vehicleText
        }
        
        if appointment?.appointmentStatus == nil {
            
            self.apptStatus.text = ""
        } else {
            guard let status = appointment?.appointmentStatus.name else {
                return
            }
            self.apptStatus.text = "Status: \(status)"
        }
    }
}



























