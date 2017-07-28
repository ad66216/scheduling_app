//
//  VehicleStatus.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/27/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation
import Parse

class VehicleStatus : PFObject, PFSubclassing
{
    @NSManaged var name: String
    @NSManaged var desc: String?
    @NSManaged var statusId: Int
    
    static func parseClassName() -> String {
        
        return "VehicleStatus"
    }
}





















