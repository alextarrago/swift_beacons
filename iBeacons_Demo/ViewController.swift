//
//  ViewController.swift
//  iBeacons_Demo
//
//  Created by Alex Tarrago on 03/06/14.
//  Copyright (c) 2014 Dribba. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, BeaconsManagerDelegate, UIAlertViewDelegate {
    @IBOutlet var beaconAlert : UILabel = nil
    @IBOutlet var indicator : UIActivityIndicatorView = nil
    var beaconsManager:BeaconsManager = BeaconsManager()
    
    // View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        startLocatingBeacons()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Custom Methods
    func startLocatingBeacons (){
        println("Start locating beacons")
        self.beaconAlert.text = "Looking for beacons..."
        indicator.startAnimating()
        beaconsManager.startBeaconMonitoring()
    }
    
    // DBBeaconsManagerDelegate
    func didDiscoverBeaconWithInformation(beaconInfo: DBBeacon) {
        beaconsManager.stopBeaconMonitoring()
        self.beaconAlert.text = "Beacon found"
        indicator.stopAnimating()

        var alert:UIAlertView
        alert = UIAlertView(title: "Beacon Alert", message: "ID:\(beaconInfo.ID)\n Major:\(beaconInfo.major)\n Minor:\(beaconInfo.minor)\n Distance:\(beaconInfo.distance)\n", delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
    
    // UIAlertViewDelegate Methods
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        self.beaconAlert.text = "Looking for beacons..."
        indicator.startAnimating()
        beaconsManager.startBeaconMonitoring()
    }

}

