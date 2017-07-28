//
//  ScheduleViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/23/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import CVCalendar
import Parse

class ScheduleViewController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate  {

    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    var appointment: Appointment!
    var isEditMode: Bool = false
    var scheduleChanged : ((Appointment) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.delegate = self;
        calendarView.delegate = self;
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    // MARK: Optional methods
    
//    func calendar() -> Calendar? {
//        return currentCalendar
//    }
    
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        //return weekday == .sunday ? UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0) : UIColor.white
        return weekday == .sunday ? UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0) : UIColor.white
    }
    
//    func shouldShowWeekdaysOut() -> Bool {
//        return shouldShowDaysOut
//    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    private func shouldSelectDayView(dayView: DayView) -> Bool {
        return arc4random_uniform(3) == 0 ? true : false
    }
    
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
    }
    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
//        if let apptDate = appointment.date {
//            apptDate = dayView.date.day
//        }
        appointment.date = dayView.date.day
        appointment.month = dayView.date.month
        appointment.year = dayView.date.year
        appointment.dateTime = dayView.date.convertedDate()!
        
        switch dayView.date.weekDay()! {
        case Weekday.sunday:
            appointment["dayOfWeek"] = "Sunday"
        case Weekday.monday:
            appointment["dayOfWeek"] = "Monday"
        case Weekday.tuesday:
            appointment["dayOfWeek"] = "Tuesday"
        case Weekday.wednesday:
            appointment["dayOfWeek"] = "Wednesday"
        case Weekday.thursday:
            appointment["dayOfWeek"] = "Thursday"
        case Weekday.friday:
            appointment["dayOfWeek"] = "Friday"
        case Weekday.saturday:
            appointment["dayOfWeek"] = "Saturday"
            break
        }
        self.performSegue(withIdentifier: "timesSegue", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TimesViewController
        destinationVC.appointment = appointment
        destinationVC.isEditMode = self.isEditMode
        destinationVC.scheduleChanged = self.scheduleChanged
    }
    
//    func shouldSelectRange() -> Bool {
//        return true
//    }
    
//    func didSelectRange(from startDayView: DayView, to endDayView: DayView) {
//        print("RANGE SELECTED: \(startDayView.date.commonDescription) to \(endDayView.date.commonDescription)")
//    }
//
//    func presentedDateUpdated(_ date: CVDate) {
//        if monthLabel.text != date.globalDescription && self.animationFinished {
//            let updatedMonthLabel = UILabel()
//            updatedMonthLabel.textColor = monthLabel.textColor
//            updatedMonthLabel.font = monthLabel.font
//            updatedMonthLabel.textAlignment = .center
//            updatedMonthLabel.text = date.globalDescription
//            updatedMonthLabel.sizeToFit()
//            updatedMonthLabel.alpha = 0
//            updatedMonthLabel.center = self.monthLabel.center
//            
//            let offset = CGFloat(48)
//            updatedMonthLabel.transform = CGAffineTransform(translationX: 0, y: offset)
//            updatedMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
//            
//            UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//                self.animationFinished = false
//                self.monthLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
//                self.monthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
//                self.monthLabel.alpha = 0
//                
//                updatedMonthLabel.alpha = 1
//                updatedMonthLabel.transform = CGAffineTransform.identity
//                
//            }) { _ in
//                
//                self.animationFinished = true
//                self.monthLabel.frame = updatedMonthLabel.frame
//                self.monthLabel.text = updatedMonthLabel.text
//                self.monthLabel.transform = CGAffineTransform.identity
//                self.monthLabel.alpha = 1
//                updatedMonthLabel.removeFromSuperview()
//            }
//            
//            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
//        }
//    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
    
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .short
    }
    
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRect(x: 0, y: 0, width: $0.width, height: $0.height)) }
    }
    
    func shouldShowCustomSingleSelection() -> Bool {
        return false
    }
    
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        
        dayView.setNeedsLayout()
        dayView.layoutIfNeeded()
        
        let π = Double.pi
        
        let ringLayer = CAShapeLayer()
        let ringLineWidth: CGFloat = 4.0
        let ringLineColour = UIColor.blue
        
        let newView = UIView(frame: dayView.frame)
        
        let diameter = (min(newView.bounds.width, newView.bounds.height))
        let radius = diameter / 2.0 - ringLineWidth
        
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.cgColor
        
        let centrePoint = CGPoint(x: newView.bounds.width/2.0, y: newView.bounds.height/2.0)
        let startAngle = CGFloat(-π/2.0)
        let endAngle = CGFloat(π * 2.0) + startAngle
        let ringPath = UIBezierPath(arcCenter: centrePoint,
                                    radius: radius,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
        
        ringLayer.path = ringPath.cgPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
//    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
//        
//        guard let currentCalendar = currentCalendar else {
//            return false
//        }
//        var components = Manager.componentsForDate(Foundation.Date(), calendar: currentCalendar)
//        
//        /* For consistency, always show supplementaryView on the 3rd, 13th and 23rd of the current month/year.  This is to check that these expected calendar days are "circled". There was a bug that was circling the wrong dates. A fix was put in for #408 #411.
//         
//         Other month and years show random days being circled as was done previously in the Demo code.
//         */
//        
//        if dayView.date.year == components.year &&
//            dayView.date.month == components.month {
//            
//            if (dayView.date.day == 3 || dayView.date.day == 13 || dayView.date.day == 23)  {
//                print("Circle should appear on " + dayView.date.commonDescription)
//                return true
//            }
//            return false
//        } else {
//            
//            if (Int(arc4random_uniform(3)) == 1) {
//                return true
//            }
//            
//            return false
//        }
//        
//    }
    
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.white
    }
    
    func dayOfWeekBackGroundColor() -> UIColor {
        return UIColor.orange
    }
    
    func disableScrollingBeforeDate() -> Date {
        return Date()
    }
    
    func maxSelectableRange() -> Int {
        return 14
    }
    
    func earliestSelectableDate() -> Date {
        return Date()
    }
    
    func latestSelectableDate() -> Date {
        var dayComponents = DateComponents()
        dayComponents.day = 70
        let calendar = Calendar(identifier: .gregorian)
        if let lastDate = calendar.date(byAdding: dayComponents, to: Date()) {
            return lastDate
        } else {
            return Date()
        }
    }
}
