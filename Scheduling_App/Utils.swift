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
    
    static func getMonthName(month: Int) -> String {
        var monthName = ""
        if month == 1 {
            monthName = "January"
        } else if month == 2 {
            monthName = "February"
        } else if month == 3 {
            monthName = "March"
        } else if month == 4 {
            monthName = "April"
        } else if month == 5 {
            monthName = "May"
        } else if month == 6 {
            monthName = "June"
        } else if month == 7 {
            monthName = "July"
        } else if month == 8 {
            monthName = "August"
        } else if month == 9 {
            monthName = "September"
        } else if month == 10 {
            monthName = "October"
        } else if month == 11 {
            monthName = "November"
        } else if month == 12 {
            monthName = "December"
        }
        return monthName
    }
    
    static func convertMinutesToDateString(minutes: Double) -> String {
        let hours = Int(floor(minutes) / 60)
        let mins = Int(floor(minutes).truncatingRemainder(dividingBy: 60))
        var date = ""
        if minutes <= 719 {
            date = String(format:"%d:%02d", hours, mins) + "am"
        }
        else {
            date = String(format:"%d:%02d", hours - 12, mins) + "pm"
        }
        return date
    }
    
    static func getAmOrPm(minutes: Int) -> String {
        if minutes < 720 {
            return "am"
        } else {
            return "pm"
        }
    }
    
    static func getApptMinutes(minutes: Int) -> String {
        if minutes == 0 {
            return "00"
        } else {
            return String(minutes)
        }
    }

}





















