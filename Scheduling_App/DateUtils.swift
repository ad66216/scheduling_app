//
//  DateUtils.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/7/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation

class DateUtils
{
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
        if minutes < 720 {
            date = String(format:"%d:%02d", hours, mins) + "am"
        } else {
            date = String(format:"%d:%02d", hours, mins) + "pm"
        }
        return date
    }
}









