//
//  Vehicle.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/30/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation
import Parse

class Vehicle : PFObject, PFSubclassing {
    
    @NSManaged var color: String!
    @NSManaged var model: String!
    @NSManaged var make: String!
    @NSManaged var vin: String!
    @NSManaged var year: Int
    @NSManaged var user: PFUser!
    @NSManaged var image: PFFile?
    
    
    var uiImage: UIImage?
    
//    var color: String!
//    var model: String!
//    var make: String!
//    var vin: String!
//    var year: Int?
//    var user: PFUser!
    
    static func parseClassName() -> String {
        return "Vehicle"
    }
}
