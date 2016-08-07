//
//  CameraViewController.swift
//  HumD
//
//  Created by Jessica Joseph on 8/6/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit
import MapKit

class CameraViewController: UIViewController, ARLocationDelegate, ARDelegate, ARMarkerDelegate {
    
    var locations: NSArray?
    var userLocation: MKUserLocation?
    var arController: AugmentedRealityController?
    var geoLocation: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("should be doing stuff")
        if arController == nil {
            arController = AugmentedRealityController(view: self.view!, parentViewController: self, withDelgate: self)
            
            print("should have initialized haha")
        }
        arController?.minimumScaleFactor = 0.5
        arController?.scaleViewsBasedOnDistance = true
        arController?.rotateViewsBasedOnPerspective = true
        arController?.debugMode = false
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    func didUpdate(_ newHeading: CLHeading) {
    }
    
    func didUpdate(_ newLocation: CLLocation) {
    }
    
    func didUpdate(_ orientation: UIDeviceOrientation) {
    }
    
    
    
    func geoLocations() -> NSMutableArray! {
        return nil
    }
    
    func locationClicked(_ coordinate: ARGeoCoordinate!) {
    }
    
    func didTapMarker(_ coordinate: ARGeoCoordinate!) {
        
    }
    
}
