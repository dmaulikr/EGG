//
//  TwitterViewController.swift
//  HumD
//
//  Created by Jessica Joseph on 8/7/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterViewController: UIViewController {
    
    @IBOutlet weak var twitterLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.view.backgroundColor = UIColor(colorLiteralRed: 162.0/256.0, green: 254.0/256.0, blue: 1.0, alpha: 1.0)
        
        let store = Twitter.sharedInstance().sessionStore
        let sessions = store.existingUserSessions()
        
        if (sessions.count != 0) {
        }
    }
    
    
    
    
     @IBAction func twitterLogin(_ sender: AnyObject) {
    
        Twitter.sharedInstance().logIn(completion: { session, error in
            
            if (session != nil) {
                print("signed in as \(session?.userName)");
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ar") as! CameraViewController
                viewController.loggedInAs = session?.userName
                
                self.present(viewController, animated: true, completion: nil)
                
            } else {
                print("error: \(error?.localizedDescription)");
            }
        
        
        })
    }
    @IBAction func noTwitterLogin(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ar") as! CameraViewController
        viewController.loggedInAs = "GUEST"
        
        self.present(viewController, animated: true, completion: nil)
        
    }
}
