//
//  File.swift
//  egg
//
//  Created by Jessica Joseph on 11/19/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit
import TwitterKit
import Alamofire

class TweetController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic pTNVdxXS6KJwsbzJ2E2GDFiEl",
            "Accept": "application/json"
        
        ]
        
        
        Alamofire.request("https://api.twitter.com/1.1/trends/closest.json", headers: headers).responseJSON { response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
        
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
        }
        
        
    }

}

