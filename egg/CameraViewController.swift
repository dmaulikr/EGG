//
//  FlipsideViewController.swift
//  Around Me-Swift
//
//  Created by Nio Nguyen on 6/5/15.
//  nio.huynguyen@gmail.com
//  Copyright (c) 2015 Nio Nguyen. All rights reserved.
//

import UIKit
import MapKit
import TwitterKit

class CameraViewController: UIViewController, ARLocationDelegate, ARDelegate, ARMarkerDelegate, MarkerViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var updatingLocation = false

    
    var loggedInAs: String!
    @IBOutlet weak var usernameNav: UINavigationBar!

    
    var userLocation:MKUserLocation?
    var locations = [Place]()
    var currentLocation : CLLocation?

    var geoLocationsArray = [ARGeoCoordinate]()
    var _arController:AugmentedRealityController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameNav.topItem?.title = "Logged In As \(self.loggedInAs!)"

        let authStatus : CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        if updatingLocation {
            stopLocationManager()
        } else {
            startLocationManager()
            print("starting location manager")
        }

        
        
        
        let store = Twitter.sharedInstance().sessionStore
        let sessions = store.existingUserSessions()
        
        if (sessions.count != 0) {
    
        }

        
        if (_arController == nil) {
            _arController = AugmentedRealityController(view: self.view, parentViewController: self, withDelgate: self)
            
            _arController!.minimumScaleFactor = 0.5
            _arController!.scaleViewsBasedOnDistance = true
            _arController!.rotateViewsBasedOnPerspective = true
            _arController!.debugMode = false
        }
        // geoLocations()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateGeoLocations() {
        
        print("in the generator")
        
        print("oh and the size of locations is \(locations.count)")
        
            for place in locations {
                
                let coordinate:ARGeoCoordinate = ARGeoCoordinate(location: place.location, locationTitle: place.placeName)
                coordinate.calibrate(usingOrigin: userLocation?.location)
                
                let markerView:MarkerView = MarkerView(_coordinate: coordinate, _delegate: self)
                coordinate.displayView = markerView
                
                _arController?.addCoordinate(coordinate)
                geoLocationsArray.append(coordinate)
            }
        
    }
    
    func locationClicked(_ coordinate:ARGeoCoordinate) {
        
    }
    
    func geoLocations() -> NSMutableArray{
        
        if(geoLocationsArray.count == 0) {
            print("I'm about to generate some locations")
            generateGeoLocations()
        }
        return NSMutableArray(array: geoLocationsArray) ;
        
    }
    
    func locationClicked() {
    }
    
    func didUpdate(_ newHeading:CLHeading){
        
    }
    func didUpdate(_ newLocation:CLLocation){
        
    }
    func didUpdate(_ orientation:UIDeviceOrientation) {
        
    }
    
    func didTapMarker(_ coordinate:ARGeoCoordinate) {
        
    }
    
    func didTouchMarkerView(_ markerView:MarkerView) {
        
    }
    
    
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
        }
    }
    
    func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let lastLocation = locations.last as! CLLocation
        if (currentLocation == nil) {
            randomLocation(lastLocation, number: 10)
        }
        currentLocation = lastLocation
        
        let accuracy:CLLocationAccuracy = lastLocation.horizontalAccuracy
        if(accuracy < 100.0) {
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.14 / 10, 0.14 / 10);
            let region:MKCoordinateRegion = MKCoordinateRegionMake(lastLocation.coordinate,span)
        }
    }
    

    func randomLocation(_ location:CLLocation, number:Int) {
        for _ in 1...number {
            var newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
            var place = Place(_location: newLocation, _reference: "_reference", _placeName: "Steven Piggy's Park", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
            locations.append(place)
        } 
        
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
