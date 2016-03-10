//
//  ViewController.swift
//  DemoSwift
//
//  Created by paraline on 3/10/16.
//  Copyright © 2016 paraline. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization();
        locationManager.startUpdatingLocation();
        
        
        let proximityUUID = NSUUID(UUIDString: "00000000-49b5-1001-b000-001c4d60c22a");
        let beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID!, identifier: "ibeacon1");
        beaconRegion.notifyEntryStateOnDisplay = true;
        
        
        self.locationManager.startRangingBeaconsInRegion(beaconRegion);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: CLLocationManagerDelegate

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        NSLog("didUpdateLocations \(locations.last)");
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        NSLog("didChangeAuthorizationStatus \(status.rawValue)");
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
         NSLog("didEnterRegion \(region)");
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
         NSLog("didExitRegion \(region)");
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if(beacons.count>0){
            let nearestBeacon : CLBeacon = beacons.first!;
            NSLog("nearestBeacon \(nearestBeacon) uuid:\(nearestBeacon.proximityUUID.UUIDString) major:\(nearestBeacon.major) minor:\(nearestBeacon.minor) rssi:\(nearestBeacon.rssi)")
//            switch (nearestBeacon.proximity){
//                case CLProximity.Near:
//                    break;
//            default{
//                
//                }
//            }
            
        }
    }
    
    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
        NSLog("didRangeBeacons \(error)");
    }
}

