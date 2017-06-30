//
//  Schedule.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/29/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation
import Parse

class Schedule : PFObject, PFSubclassing {
    
    @NSManaged var dayOfWeek: String
    @NSManaged var timeSlots: NSArray
    
    static func parseClassName() -> String {
        return "Schedule"
    }
}
