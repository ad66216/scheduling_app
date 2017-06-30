    //
//  VehicleListViewController.swift
//  Scheduling_App
//
//  Created by Alex Danner on 6/30/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import UIKit
import Parse

class VehicleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var vehicleListTableView: UITableView!
    
    var vehicle: Vehicle!
    var vehicleList: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
//        let displayWidth: CGFloat = self.view.frame.width
//        let displayHeight: CGFloat = self.view.frame.height
        
        vehicleList = NSMutableArray()
        
//        vehicleListTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        vehicleListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        vehicleListTableView.dataSource = self
        vehicleListTableView.delegate = self
        self.view.addSubview(vehicleListTableView)
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
                self.vehicleListTableView.reloadData();
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vehicleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
    
        if (self.vehicleList.count > indexPath.row) {
            let vehicle = self.vehicleList.object(at: indexPath.row) as? Vehicle
            
            let text = (vehicle?.make)! + " " + (vehicle?.model)!
            cell.textLabel!.text = text
        }
        
        return cell
    }
}











