//
//  PlacesLoader.swift
//  HumD
//
//  Created by Jessica Joseph on 8/6/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.

import Foundation
import CoreLocation

let apiURL: String = "https://maps.googleapis.com/maps/api/place/"
let apiKey: String = "AIzaSyC9YwGYumXIlf10N0-bn_uizMsILeCDr8Q"

typealias SuccessHandler = (responseDict: [NSObject : AnyObject]) -> Void
typealias ErrorHandler = (error: NSError) -> Void

class PlacesLoader: NSObject {
    
    
    var successHandler: SuccessHandler
    var errorHandler: ErrorHandler
    var responseData: NSMutableData
    //3
    class func sharedInstance() -> PlacesLoader {
        
        //1
        var instance: PlacesLoader? = nil
        var onceToken: dispatch_once_t = 0
        //2
        dispatch_once(onceToken, {() -> Void in
            instance = PlacesLoader()
        })
        //3
        return instance!
    }
    //4
    
    func loadPOIsForLocation(location: CLLocation, radius: Int, successHandler handler: SuccessHandler, errorHandler: ErrorHandler) {
        
        //1
        responseData = nil
        self.successHandler = handler
        self.errorHandler = errorHandler
        //2
        var latitude: CLLocationDegrees = location.coordinate.latitude
        var longitude: CLLocationDegrees = location.coordinate.longitude
        //3
        var uri: String = String(string: apiURL)
        uri += String(format: "nearbysearch/json?location=%f,%f&radius=%d&sensor=true&types=establishment&key=%@", latitude, longitude, radius, apiKey)
        //4
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: uri.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding))!, cachePolicy: NSURLRequestReloadIgnoringCacheData, timeoutInterval: 20.0)
        //5
        request.httpShouldHandleCookies = true
        request.HTTPMethod = "GET"
        //6
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self)
        
        //7
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        print("Starting connection: \(connection) for request: \(request)")
    }
    
    
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        if !responseData {
            self.responseData = NSMutableData(data: data as Data)
        }
        else {
            responseData.appendData(data as Data)
        }
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        var object: AnyObject = try! JSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingAllowFragments)
        if successHandler {
            successHandler(object)
        }
    }
    
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError?) {
        if errorHandler {
            errorHandler(error)
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
}
