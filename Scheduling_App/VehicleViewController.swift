//
//  VehicleViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/22/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse

class VehicleViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var vinTextField: UITextField!
    @IBOutlet weak var vehicleImageView: UIImageView!
    
    var vehicle: Vehicle!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        makeTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        modelTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        colorTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        vinTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        
        if vehicle != nil {
            yearTextField.text = String(vehicle.year)
            makeTextField.text = vehicle.make
            modelTextField.text = vehicle.model
            colorTextField.text = vehicle.color
            vinTextField.text = vehicle.vin
            
            vehicle.image?.getDataInBackground(block: { (imageData: Data?, error: Error?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.vehicleImageView.contentMode = .scaleAspectFit
                        self.vehicleImageView.image = image
                    }
                }
            })
            
        }
        
        imagePicker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addVehicleClick(_ sender: Any) {
        
        self.saveVehicle()
    }
    
    @IBAction func addVehicleImage(_ sender: Any) {
        
        //        self.btnEdit.setTitleColor(UIColor.white, for: .normal)
        //        self.btnEdit.isUserInteractionEnabled = true
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            vehicleImageView.contentMode = .scaleAspectFit
            vehicleImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func saveVehicle() {
        if self.vehicle == nil {
            
            self.vehicle = Vehicle()
        }
        
        let yearStr = yearTextField.text
        
        if yearStr != "" {
            vehicle.year = Int(yearStr!)!
        }
        
        vehicle.make = makeTextField.text
        vehicle.model = modelTextField.text
        vehicle.color = colorTextField.text
        vehicle.vin = vinTextField.text
        vehicle.user = PFUser.current()
        
        let imageData = UIImagePNGRepresentation(vehicleImageView.image!)
        let imageFile = PFFile(name:"image.png", data:imageData!)

        vehicle.image = imageFile
        
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



























