////
////  Twitter.swift
////  HumD
////
////  Created by Jessica Joseph on 8/7/16.
////  Copyright © 2016 Jessica Joseph. All rights reserved.
////
//
//import UIKit
//import TwitterKit
//
//class TwitterViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let logInButton = TWTRLogInButton { (session, error) in
//            if let unwrappedSession = session {
//                let alert = UIAlertController(title: "Logged In",
//                                              message: "User \(unwrappedSession.userName) has logged in",
//                                              preferredStyle: UIAlertControllerStyle.alert
//                )
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                
//                // get timeline
//                
//                let parameter : [String : AnyObject] = ["screen_name" : (session?.userName)! , "count" : "200"]
//              
//
////                let request = TWTRAPIClient.urlRequest(withMethod: "GET", url: "https://api.twitter.com/1.1/statuses/user_timeline.json", parameters: parameter, error: nil)
//                
////
////                let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod("GET", URL: "https://api.twitter.com/1.1/statuses/user_timeline.json", parameters: parameter, error: nil)
//                
//                
//                var response : URLResponse?
//                let data = try! NSURLConnection.sendSynchronousRequest(request, returning: &response)
//                let arrayRep = try! JSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
//                print(arrayRep)
//                
//                
//                
//            } else {
//                NSLog("Login error: %@", error!.localizedDescription);
//            }
//        }
//        
//        // TODO: Change where the log in button is positioned in your view
//        logInButton.center = self.view.center
//        self.view.addSubview(logInButton)
//
//    }
//
//}
