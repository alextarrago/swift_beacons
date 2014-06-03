//
//  DBBeacon.swift
//  iBeacons_Demo
//
//  Created by Alex Tarrago on 03/06/14.
//  Copyright (c) 2014 Dribba. All rights reserved.
//

import Foundation

class DBBeacon:NSObject {
    var range:Int
    var ID:String
    var major:String
    var minor:String
    var distance:String
    
    init() {
        self.range = -1
        self.ID = String();
        self.major = String();
        self.minor = String();
        self.distance = String();
    }
    
    func beaconDescription () -> String {
        return "Distance: \(self.distance)\n ID: \(self.ID)\n Major: \(self.major)\n Minor: \(self.minor) ."
    }
}
