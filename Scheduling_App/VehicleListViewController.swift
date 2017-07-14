//
//  VehicleListViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/30/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse
import Material

struct ButtonLayout {
    struct Fab {
        static let diameter: CGFloat = 48
    }
}

class VehicleListViewController: UIViewController {
    
    @IBOutlet weak var vehicleListTableView: VehicleTableView!
    
    var vehicle: Vehicle!
    var vehicleList: NSMutableArray!
    
    //var appointment: Appointment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vehicleList = NSMutableArray()
        
        vehicleListTableView.rowHeight = UITableViewAutomaticDimension
        vehicleListTableView.estimatedRowHeight = 300
        
        self.view.addSubview(vehicleListTableView)
        
        // Material Design
        prepareFABButton()
        
        view.backgroundColor = Color.grey.lighten5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let query = PFQuery(className: "Vehicle")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.findObjectsInBackground { (results: [PFObject]?, error: Error?) -> Void in
            if error != nil {
                print("The getFirstObject request failed.")
            } else {
                
                self.vehicleList = NSMutableArray()
                
                for obj in results! {
                    let vehicle = obj as! Vehicle
                    self.vehicleList.add(vehicle)
                }
                
                self.vehicleListTableView.data = self.vehicleList as! [Vehicle]
//                self.vehicleListTableView.reloadData();
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.vehicleList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleCell", for: indexPath) as! VehicleTableViewCell
//                
//        if (self.vehicleList.count > indexPath.row) {
//            let vehicle = (self.vehicleList.object(at: indexPath.row) as? Vehicle)!
//            
////            let text = "\(String(describing: vehicle?.year as Optional))" + " " + (vehicle?.make)! + " " + (vehicle?.model)!
//            let text = String(vehicle.year) + " " + vehicle.make! + " " + vehicle.model! + " - " + vehicle.color!
//            cell.vehicleNameView.text = text
//            
//            vehicle.image?.getDataInBackground(block: { (imageData: Data?, error: Error?) -> Void in
//                if error == nil {
//                    if let imageData = imageData {
//                        let image = UIImage(data:imageData)?.resize(toWidth: cell.width)
//                        cell.vehicleImageView.contentMode = .scaleAspectFit
//                        cell.vehicleImageView.image = image
//                    }
//                }
//            })
//
//        }
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        let row = indexPath.row
//        print("Row: \(row)")
//        
//        let vehicle = (self.vehicleList.object(at: indexPath.row) as? Vehicle)!
//        didSelectVehicle(vehicle)
//    }
    
    func didSelectVehicle(_ vehicle: Vehicle) {
        
        // show vehicle details
        let theStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vehicleViewController = (theStoryBoard.instantiateViewController(withIdentifier: "vehicleViewController") as? VehicleViewController)!
        vehicleViewController.vehicle = vehicle
        self.navigationController?.pushViewController(vehicleViewController, animated: true)
    }
}

extension VehicleListViewController {
    fileprivate func prepareFABButton() {
        let button = FABButton(image: Icon.cm.add, tintColor: .white)
        button.pulseColor = .white
        button.backgroundColor = Color.red.base
        
        view.layout(button)
            .width(ButtonLayout.Fab.diameter)
            .height(ButtonLayout.Fab.diameter)
            .bottomRight(bottom: 80, right: 35)
        
//        (self, action: #selector(getter: UIDynamicBehavior.action), for: UIControlEvents.touchUpInside)
        button.addTarget(self, action: #selector(VehicleListViewController.action(sender:)), for: UIControlEvents.touchUpInside)
    }
    func action(sender:UIButton!) {
        let theStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vehicleViewController = theStoryBoard.instantiateViewController(withIdentifier: "vehicleViewController")
        self.navigationController?.pushViewController(vehicleViewController, animated: true)
    }
}










