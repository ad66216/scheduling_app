//
//  VehicleViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/22/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse

class VehicleViewController: UIViewController {

    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var vinTextField: UITextField!
    
    var vehicle: Vehicle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yearTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        makeTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        modelTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        colorTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        vinTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if vehicle != nil {
            yearTextField.text = String(vehicle.year)
            makeTextField.text = vehicle.make
            modelTextField.text = vehicle.model
            colorTextField.text = vehicle.color
            vinTextField.text = vehicle.vin
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addVehicleClick(_ sender: Any) {
        
        self.saveVehicle()
    }
    
    func saveVehicle() {
        if self.vehicle == nil {

        self.vehicle = Vehicle()
        }
        vehicle.year = Int(yearTextField.text!)!
        vehicle.make = makeTextField.text
        vehicle.model = modelTextField.text
        vehicle.color = colorTextField.text
        vehicle.vin = vinTextField.text
        vehicle.user = PFUser.current()
        
        vehicle.saveInBackground {
            (success: Bool, error: Error?) in
            if (success) {
                // The object has been saved.
                NSLog("Saved!")
            } else {
                // There was a problem, check error.description
                NSLog("Didn't Save!")
            }
        }
    }
}
