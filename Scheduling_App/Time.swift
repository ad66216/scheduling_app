//
//  Time.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/23/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation


struct Time {
    
    let start: TimeInterval
    let end: TimeInterval
    let interval: TimeInterval
    
    init(start: TimeInterval, interval: TimeInterval, end: TimeInterval) {
        self.start = start
        self.interval = interval
        self.end = end
    }
    
    init(startHour: TimeInterval, intervalMinutes: TimeInterval, endHour: TimeInterval) {
        self.start = startHour * 60 * 60
        self.end = endHour * 60 * 60
        self.interval = intervalMinutes * 60
    }
    
//    var timeRepresentations: [String] {
//        let dateComponentFormatter = DateComponentsFormatter()
//        dateComponentFormatter.unitsStyle = .positional
//        dateComponentFormatter.allowedUnits = [.minute, .hour]
//        
//        let dateComponent = NSDateComponents()
//        return timeIntervals.map { timeInterval in
//            dateComponent.second = Int(timeInterval)
//            return dateComponentFormatter.string(from: dateComponent as DateComponents)!
//        }
//    }
    
//    var timeIntervals: [TimeInterval]{
//        //return Array(start.stride(from:)
//        return Array(start.stride(from: start, through: end, by: interval))
//    }
    
    
}
