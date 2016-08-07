//
//  ViewController.swift
//  HumD
//
//  Created by Jessica Joseph on 8/6/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView?
    var userLocation: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.userLocation = CLLocationManager()
        userLocation?.delegate = self
        userLocation?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
//        userLocation.desiredAccuracy = kCLLocationAccuracyBest
//        userLocation.delegate = self
//        userLocation.requestAlwaysAuthorization()
//        
        
        print(userLocation?.location)
        
        print("STARTING TO UPDATE")
        userLocation?.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //1
        let lastLocation: CLLocation = locations.last!
        //2
        let accuracy: CLLocationAccuracy = lastLocation.horizontalAccuracy
        print("Received location \(lastLocation) with accuracy \(accuracy)")
        //3
        if accuracy < 100.0 {
            //4
            let span: MKCoordinateSpan = MKCoordinateSpanMake(0.14, 0.14)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(lastLocation.coordinate, span)
            mapView?.setRegion(region, animated: true)
            // More code here
            manager.stopUpdatingLocation()
        }
    }
    
    
//    func MapViewControllerDidFinish(controller: MapController)
//    {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "id" {
//            segue.destinationViewController.transitioningDelegate = self
//        }
//    }

}

