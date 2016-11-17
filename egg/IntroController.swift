//
//  IntroController.swift
//  egg
//
//  Created by Jessica Joseph on 11/17/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit
import JTMaterialTransition

class IntroController: UIViewController {
    
    @IBOutlet weak var introLogo: UIButton!
    var transition: JTMaterialTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.transition = JTMaterialTransition(animatedView: self.introLogo!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    @IBAction func didTouch(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "twitterLogin")
        
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self.transition
        self.present(controller, animated: true, completion: nil)
    }
    
    
    
}


