//
//  Appointment.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/29/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation
import Parse

class Appointment : PFObject, PFSubclassing {
    
    @NSManaged var date: Int
    @NSManaged var month: Int
    @NSManaged var year: Int
    @NSManaged var dayOfWeek: String
    @NSManaged var time: Int
    @NSManaged var serviceType: String
    @NSManaged var appointmentType: String
    @NSManaged var user: PFUser
    @NSManaged var dateTime: Date
    @NSManaged var vehicle: Vehicle
    
    static func parseClassName() -> String {
        return "Appointment"
    }
}
