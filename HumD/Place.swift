////
////  Place.swift
////  HumD
////
////  Created by Jessica Joseph on 8/7/16.
////  Copyright © 2016 Jessica Joseph. All rights reserved.
////
//
//import Foundation
//
//
//class Place: CLLocation{
//
//    var location: CLLocation?
//    var reference: NSString = ""
//    var placeName: NSString = ""
//    var address: NSString = ""
////    
////    init(location: CLLocation, reference: String, name: String, address: String) {
////        if (super.init(latitude: <#T##CLLocationDegrees#>
////            super.init()
////
////            ) {
////            self.location = location
////            self.reference = reference
////            self.placeName = name
////            self.address = address
////        }
////    }
////    
////    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//}



import CoreLocation
import MapKit

class Place : NSObject , MKAnnotation {
    var location:CLLocation!
    var reference:String! = ""
    var placeName:String! = ""
    var address:String! = ""
    var phoneNumber:String! = ""
    var website:String! = ""
    
    init(_location: CLLocation, _reference: String, _placeName: String, _address: String, _phoneNumber: String, _website: String) {
        self.location       = _location
        self.reference      = _reference
        self.placeName      = _placeName
        self.address        = _address
        self.phoneNumber    = _phoneNumber
        self.website    = _website
    }
    
    func infoText() -> String {
        var mutableString:String = ""
        
        if(self.placeName != "") {
            mutableString += "Name: \(self.placeName)\n\n"
        }
        
        if(self.address != "") {
            mutableString += "Address: \(self.address)\n\n"
        }
        
        if(self.phoneNumber != "") {
            mutableString += "Phone Number: \(self.phoneNumber)\n\n"
        }
        if(self.website != "") {
            mutableString += "Website: \(self.website)\n\n"
        }
        return mutableString
    }
    
    @objc var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.location!.coordinate.latitude, self.location!.coordinate.longitude)
    }
    
    
    var title: String! {
        if infoText().isEmpty {
            return "(No Description)"
        } else {
            return infoText()
        }
    }
    
    var subtitle: String! {
        return infoText()
    }
}
