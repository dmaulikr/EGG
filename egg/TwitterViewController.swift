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
        
        
        let store = Twitter.sharedInstance().sessionStore
        let sessions = store.existingUserSessions()
        
        if (sessions.count != 0) {
            self.twitterLogin.setBackgroundImage(UIImage(named: "twitter-loggedon.png"), for: .normal)
        }
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
