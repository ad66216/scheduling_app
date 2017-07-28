//
//  AppointmentDetailViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/21/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse
import Material

class AppointmentDetailViewController: UIViewController {

    @IBOutlet weak var apptTypeLabel: UILabel!
    @IBOutlet weak var apptDateLabel: UILabel!
    @IBOutlet weak var apptVehicleLabel: UILabel!
    @IBOutlet weak var apptStatusLabel: UILabel!
    @IBOutlet weak var apptDescLabel: UILabel!
    
    var appointment: Appointment!
    
    let theStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil);
//        self.navigationItem.leftBarButtonItem = backButton
        
        let monthName = Utils.getMonthName(month: appointment.month)
        let apptHour = Utils.formatHourFromMinutes(minutes: appointment.time)
        
        let apptMin = Utils.getApptMinutes(minutes: appointment.time % 60)
        let apptAmOrPm = Utils.getAmOrPm(minutes: appointment.time)
        let apptTime = "\(apptHour):\(apptMin)\(apptAmOrPm)"
        let dateTimeText = "\(appointment.dayOfWeek), \(monthName) \(appointment.date), \(appointment.year) @ \(apptTime)"
        self.apptDateLabel.text = dateTimeText
        
        self.apptTypeLabel.text = Utils.convertServiceType(type: appointment.serviceType)
        self.apptStatusLabel.text = appointment.tracking.appointmentStatus.name
        self.apptVehicleLabel.text = Utils.getVehicleInfo(vehicle: appointment.vehicle)
        self.apptDescLabel.text = appointment.tracking.appointmentStatus.desc
        apptDescLabel.numberOfLines = 0;
        apptDescLabel.sizeToFit()
    }
    @IBAction func editApptTypeDidTap(_ sender: Any) {
        
        let serviceOfferedViewController = theStoryBoard.instantiateViewController(withIdentifier: "servicesOfferedViewController") as? ServicesOfferedViewController
        serviceOfferedViewController?.isEditMode = true
        serviceOfferedViewController?.appointmentEdit = self.appointment
        serviceOfferedViewController?.serviceTypedChanged = {(serviceType: String) -> Void in
            
            self.appointment.serviceType = serviceType
            self.appointment.saveInBackground()
            self.apptTypeLabel.text = Utils.convertServiceType(type: self.appointment.serviceType)
        }
        
        self.navigationController?.pushViewController(serviceOfferedViewController!, animated: true)
    }
    
    @IBAction func editApptDateDidTap(_ sender: Any) {
        
//        let scheduleViewController = theStoryBoard.instantiateViewController(withIdentifier: "scheduleViewController") as? ScheduleViewController
//        
//        scheduleViewController?.isEditMode = true
//        scheduleViewController?.scheduleChanged = {(appointment: Appointment) -> Void in
//            self.appointment.dateTime = appointment.dateTime
//            scheduleViewController?.appointment = self.appointment
//            self.appointment.saveInBackground()
//            self.apptTypeLabel.text = Utils.convertServiceType(type: self.appointment.serviceType)
//        }
    
        self.navigationController?.performSegue(withIdentifier: "editApptDateTimeSegue", sender: self)
    }
    
    @IBAction func editApptVehicleDidTap(_ sender: Any) {
        
        let selectVehicleViewController = theStoryBoard.instantiateViewController(withIdentifier: "selectVehicleListViewController") as? SelectVehicleViewController
        
        selectVehicleViewController?.isEditMode = true
        selectVehicleViewController?.appointmentEdit = self.appointment
        selectVehicleViewController?.vehicleChanged = {(vehicle: Vehicle) -> Void in
            
            self.appointment.vehicle = vehicle
            self.appointment.saveInBackground()
            self.apptVehicleLabel.text = Utils.getVehicleInfo(vehicle: vehicle)
        }
        
        self.navigationController?.pushViewController(selectVehicleViewController!, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let scheduleViewController = segue.destination as! ScheduleViewController
        scheduleViewController.appointment = self.appointment
        scheduleViewController.isEditMode = true
        scheduleViewController.scheduleChanged = {(appointment: Appointment) -> Void in
//            self.appointment.dateTime = appointment.dateTime
            self.appointment.saveInBackground()
            self.apptDateLabel.text = Utils.getApptDateTime(appointment: appointment)
            self.apptTypeLabel.text = Utils.convertServiceType(type: self.appointment.serviceType)
        }
    }
}



























