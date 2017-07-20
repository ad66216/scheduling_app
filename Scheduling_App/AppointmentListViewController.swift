//
//  AppointmentListViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/7/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse

class AppointmentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var appointmentTableView: UITableView!
    
    var appointment: Appointment!
    var appointmentList: NSMutableArray!
    //var appointment: Appointment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appointmentList = NSMutableArray()
        appointmentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        appointmentTableView.dataSource = self
        appointmentTableView.delegate = self
        self.view.addSubview(appointmentTableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let query = PFQuery(className: "Appointment")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.includeKey("vehicle")
        query.findObjectsInBackground { (results: [PFObject]?, error: Error?) -> Void in
            if error != nil {
                print("The getFirstObject request failed.")
            } else {
                
                self.appointmentList = NSMutableArray()
                
                for obj in results! {
                    let appointment = obj as! Appointment
                    self.appointmentList.add(appointment)
                }
                self.appointmentTableView.reloadData();
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath as IndexPath) as? AppointmentTableViewCell
        
        if (self.appointmentList.count > indexPath.row) {
//            if let appointment = (self.appointmentList.object(at: indexPath.row) as? Appointment) {
            let appointment = (self.appointmentList.object(at: indexPath.row) as? Appointment)!

            cell?.appointment = appointment
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print("Row: \(row)")
        
        //let appointment = (self.appointmentList.object(at: indexPath.row) as? Appointment)!
        //didSelectAppointment(appointment)
    }
    @IBAction func newApptDidSelect(_ sender: Any) {
        
        let theStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vehicleViewController = theStoryBoard.instantiateViewController(withIdentifier: "servicesOfferedViewController")
        self.navigationController?.pushViewController(vehicleViewController, animated: true)
    }
    
    
}

















