//
//  Utils.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/20/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation


class Utils
{
    static func convertServiceType(type: String) -> String {
        var newText: String
        
        if type == "tireRotation" {
            newText = "Tire Rotation"
        } else if type == "oilChange" {
            newText = "Oil Change"
        } else if type == "maintenance" {
            newText = "Preventative Maintenance"
        } else if type == "other" {
            newText = "Other"
        } else {
            newText = ""
        }
        return newText
    }
}





















