//
//  CameraViewController.swift
//  HumD
//
//  Created by Jessica Joseph on 8/6/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit
import MapKit


class CameraViewController: UIViewController, ARLocationDelegate, ARDelegate, ARMarkerDelegate, MarkerViewDelegate {
    
    var locations = [Place]()
    var userLocation: MKUserLocation?
    var arController: AugmentedRealityController?
    var geoLocationsArray = [ARGeoCoordinate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aPlaceLocation = CLLocation(latitude: 40.36490159, longitude: -74.16752175)
        let aPlace = Place(_location: aPlaceLocation, _reference: "BLAH", _placeName: "MLH Prime", _address: "Bell Works", _phoneNumber: "3477571216", _website: "jessicajoseph.co")
        
        locations.append(aPlace)
        
        print("should be doing stuff")
        if arController == nil {
            arController = AugmentedRealityController(view: self.view!, parentViewController: self, withDelgate: self)
            
            print("should have initialized haha")
        }
        arController?.minimumScaleFactor = 0.5
        arController?.scaleViewsBasedOnDistance = true
        arController?.rotateViewsBasedOnPerspective = true
        arController?.debugMode = false
        
        geoLocations()
 
        
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
    
    func generateGeoLocations() {
        for place in locations {
            let coordinate:ARGeoCoordinate = ARGeoCoordinate(location: place.location, locationTitle: place.placeName)
            coordinate.calibrate(usingOrigin: userLocation?.location)
            
            let markerView:MarkerView = MarkerView(_coordinate: coordinate, _delegate: self)
            coordinate.displayView = markerView
            
            arController?.addCoordinate(coordinate)
            geoLocationsArray.append(coordinate)
            
            print("IN GENERATOR, new geolocations \(geoLocationsArray)")
        }
        
    }

    
    
    func geoLocations() -> NSMutableArray{
        
        print("IN GEOLOCATIONS")
        print("Geolocations count is \(geoLocationsArray.count)")
        if(geoLocationsArray.count == 0) {
            generateGeoLocations()
        }
        return NSMutableArray(array: geoLocationsArray) ;
        
    }
    
    func locationClicked(_ coordinate: ARGeoCoordinate!) {
    }
    
    func didTapMarker(_ coordinate: ARGeoCoordinate!) {
        
    }
    
    func didTouchMarkerView(_ markerView:MarkerView) {
        
    }
    
    
    
    
    
}
