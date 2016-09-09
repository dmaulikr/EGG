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

class CameraViewController: UIViewController, ARLocationDelegate, ARDelegate, ARMarkerDelegate, MarkerViewDelegate {
    
    @IBOutlet weak var twitterLogin: UIButton!
    
    var userLocation:MKUserLocation?
    var locations = [Place]()
    var geoLocationsArray = [ARGeoCoordinate]()
    var _arController:AugmentedRealityController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let store = Twitter.sharedInstance().sessionStore
        let sessions = store.existingUserSessions()
        
        if (sessions.count != 0) {
            self.twitterLogin.setBackgroundImage(UIImage(named: "twitter-loggedon.png"), for: .normal)
        }

        
        if (_arController == nil) {
            _arController = AugmentedRealityController(view: self.view, parentViewController: self, withDelgate: self)
            
            _arController!.minimumScaleFactor = 0.5
            _arController!.scaleViewsBasedOnDistance = true
            _arController!.rotateViewsBasedOnPerspective = true
            _arController!.debugMode = false
        }
        geoLocations()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateGeoLocations() {
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
    
    @IBAction func doneAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func twitterLogin(_ sender: AnyObject) {
        
        Twitter.sharedInstance().logIn(completion: { session, error in
            
            if (session != nil) {
                print("signed in as \(session?.userName)");
                
                self.twitterLogin.setBackgroundImage(UIImage(named: "twitter-loggedon.png"), for: .normal)
                
            } else {
                print("error: \(error?.localizedDescription)");
            }
            
            
        })
    }
}
