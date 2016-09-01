//
//  Twitter.swift
//  HumD
//
//  Created by Jessica Joseph on 8/7/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                                              message: "User \(unwrappedSession.userName) has logged in",
                                              preferredStyle: UIAlertControllerStyle.alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
                    let client = TWTRAPIClient(userID: userID)
                
                    
                    let parameter : [String : AnyObject] = ["screen_name" : (session?.userName)! , "count" : "200"]
                    let request = client.urlRequest(withMethod: "GET", url:"https://api.twitter.com/1.1/statuses/user_timeline.json" , parameters: parameter, error: nil)
 
              var response : URLResponse?
                let data = try! NSURLConnection.sendSynchronousRequest(request, returning: &response)
                let arrayRep = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    print("PRINTING THIS ARRAY TIMELINE \(arrayRep)")
                
                }
                
                
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

    }

}
