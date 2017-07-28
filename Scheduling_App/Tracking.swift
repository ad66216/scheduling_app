//
//  Tracking.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/27/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation
import Parse

class Tracking : PFObject, PFSubclassing
{
    @NSManaged var appointment: Appointment
    @NSManaged var appointmentStatus: AppointmentStatus
    
    static func parseClassName() -> String {
    
        return "Tracking"
    }
}
























