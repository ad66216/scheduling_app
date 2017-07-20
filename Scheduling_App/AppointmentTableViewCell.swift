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
        
        let monthName = DateUtils.getMonthName(month: a.month)
        var apptHour: Int = 0
        
        if a.time < 60 {
            apptHour = 12
        } else {
            apptHour = a.time/60
        }
        let apptMin = DateUtils.getApptMinutes(minutes: a.time % 60)
        let apptAmOrPm = DateUtils.getAmOrPm(minutes: a.time)
        let apptTime = "\(apptHour):\(apptMin)\(apptAmOrPm)"
        let dateTimeText = "\(a.dayOfWeek), \(monthName) \(a.date), \(a.year) @ \(apptTime)"
        
        
        
        self.serviceType.text = Utils.convertServiceType(type: a.serviceType)
        self.apptDateTime.text = dateTimeText
//        let vehicleString: String = "\(String(describing: appointment?.vehicle.make)) \(String(describing: appointment?.vehicle.model))"
//        self.apptVehicle.text = "\(appointment?.vehicle.make) \(appointment?.vehicle.model)"
//        self.apptVehicle.text = appointment?.vehicle.make
        
        if appointment?.vehicle == nil {
            self.apptVehicle.text = ""
        } else {
            guard let vehicleMake = appointment?.vehicle.make else {
                return
            }
            guard let vehicleModel = appointment?.vehicle.model else {
                return
            }
            guard let vehicleYear = appointment?.vehicle.year else {
                return
            }
            guard let vehicleColor = appointment?.vehicle.color else {
                return
            }
            self.apptVehicle.text = "\(vehicleYear) \(vehicleMake) \(vehicleModel) - \(vehicleColor)"
        }
    }
}
