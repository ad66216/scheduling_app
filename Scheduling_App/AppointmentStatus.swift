//
//  AppointmentStatus.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/20/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation
import Parse

class AppointmentStatus : PFObject, PFSubclassing
{
    @NSManaged var name: String
    
    static func parseClassName() -> String {
        
        return "AppointmentStatus"
    }
}
