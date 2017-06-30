//  TimesViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/23/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.

import UIKit
import Parse

class TimesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //private let myArray: NSArray = ["First","Second","Third"]
    //let time = Time(startHour: 8, intervalMinutes: 30, endHour: 23)
    private var myTableView: UITableView!
    //var appointment: PFObject!
    var appointment: Appointment!
    var unavailableTimeSlots: NSMutableArray!
    var schedule = Schedule()
    //var timeSlots: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Query the current Schedule to get all the times that
        let query = PFQuery(className: "Schedule")
        //query.whereKey("dayOfWeek", equalTo: appointment.dayOfWeek)
        query.getFirstObjectInBackground {
            (object: PFObject?, error: Error?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            } else {
                self.schedule = object as! Schedule
                
                // Query the current Appointments to compare to full schedule
                let query = PFQuery(className: "Appointment")
                query.whereKey("year", equalTo: self.appointment.year)
                query.whereKey("month", equalTo: self.appointment.month)
                query.whereKey("date", equalTo: self.appointment.date)
                query.findObjectsInBackground(block: { (results: [PFObject]?, error: Error?) -> Void in
                    
                    if error != nil || object == nil {
                        print("The getFirstObject request failed.")
                    } else {
                        
                        self.unavailableTimeSlots = NSMutableArray()
                        
                        for obj in results! {
                            let appt = obj as! Appointment
                            self.unavailableTimeSlots.add(appt.time)
                        }
                        self.myTableView.reloadData();
                    }
                })
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //var timesArray = NSMutableArray()
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(myArray[indexPath.row])")
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let time = Int(self.schedule.timeSlots[indexPath.row] as! String)
        self.appointment.time = time!
        
        let timeSlot = Double(self.schedule.timeSlots[indexPath.row] as! String)
        let dateTime = self.appointment.dateTime.addingTimeInterval(timeSlot! * 60)
        self.appointment.dateTime = dateTime
        
        appointment.saveInBackground(block: { (succeeded: Bool?, error: Error?) -> Void in
            if error != nil {
                print("The getFirstObject request failed.")
            } else {
                let alert = UIAlertController(title: "Success", message: "You have successfully created an appointment", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                
                // number of seconds in delay (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                    // code with delay
                    alert.dismiss(animated: true, completion: nil)
                }
//                let alert = UIAlertController(title: "Success!", message: "You have successfully created an appointment", preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
            }

        })
        print("Num: \(indexPath.row)")
        //print("Value: \(timesArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return myArray.count
        print("Time Slot Count: \(self.schedule.timeSlots.count)")
        return self.schedule.timeSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        //cell.textLabel!.text = "\(myArray[indexPath.row])"
        
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone.current
        let dateAtMidnight = calendar.startOfDay(for: Date())
        let timeSlot = Double(self.schedule.timeSlots[indexPath.row] as! String)
        let dateTime = dateAtMidnight.addingTimeInterval(timeSlot! * 60)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "hh:mm"
        let time = dateFormatterGet.string(from: dateTime)
    
        if unavailableTimeSlots.contains(Int(timeSlot!)) {
            cell.textLabel!.text = "\(time)"
            cell.textLabel?.textColor = UIColor.blue
        }
        else {
            cell.textLabel!.text = "\(time)"
        }
        return cell
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2;
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Morning"
    }
}




















