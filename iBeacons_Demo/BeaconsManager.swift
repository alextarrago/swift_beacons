//
//  BeaconsManager.swift
//  iBeacons_Demo
//
//  Created by Alex Tarrago on 03/06/14.
//  Copyright (c) 2014 Dribba. All rights reserved.
//

import Foundation
import CoreLocation
import CoreBluetooth

protocol BeaconsManagerDelegate {
    func didDiscoverBeaconWithInformation(beaconInfo:DBBeacon)
}

class BeaconsManager : NSObject, CLLocationManagerDelegate {
    var locationManager:CLLocationManager = CLLocationManager()
    let DRIBBA_PROXIMITY_UUID = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    var currentBeacon:CLBeacon = CLBeacon()
    var beaconProximity:Int = Int()
    var delegate:BeaconsManagerDelegate?
    var region:CLBeaconRegion?
    
    init (){
        var DRIBBA_UUID:NSUUID?
        DRIBBA_UUID = NSUUID(UUIDString: DRIBBA_PROXIMITY_UUID)
        
        self.locationManager = CLLocationManager()
        self.currentBeacon = CLBeacon()
        self.region = CLBeaconRegion(proximityUUID:DRIBBA_UUID, identifier: "dribba")
    }
    
    func startBeaconMonitoring (){
        
        self.locationManager.delegate = self
        self.locationManager.startMonitoringForRegion(region)
    }
    func stopBeaconMonitoring () {
        self.locationManager.stopMonitoringForRegion(region)
        self.locationManager.delegate = nil
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: AnyObject[]!, inRegion region: CLBeaconRegion!) {
        if beacons.count > 0 {
            self.currentBeacon = beacons[0] as CLBeacon
            self.beaconProximity = self.currentBeacon.proximity.toRaw() - 1
            
            var newBeacon:DBBeacon = DBBeacon()
            newBeacon.major = "\(self.currentBeacon.major)"
            newBeacon.minor = "\(self.currentBeacon.minor)"
            newBeacon.distance = "\(self.currentBeacon.accuracy)"
            self.delegate?.didDiscoverBeaconWithInformation(newBeacon)
        }
    }
}