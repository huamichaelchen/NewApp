//
//  ViewController.swift
//  NewApp
//
//  Created by Hua Chen on 2015-01-23.
//  Copyright (c) 2015 Hua Chen. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController, FBLoginViewDelegate {


    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Twitter Digits Button
        let authenticateButton = DGTAuthenticateButton(authenticationCompletion: {
            (session: DGTSession!, error: NSError!) in
            // play with Digits session
        })
        authenticateButton.center = CGPoint(x: self.view.frame.width / 2,
            y: self.view.frame.height / 8 * 7)
        self.view.addSubview(authenticateButton)
        
        
        // Twitter Account Login Button
        let logInButton = TWTRLogInButton(logInCompletion: {
            (session: TWTRSession!, error: NSError!) in
            // play with Twitter session
        })
        logInButton.center = CGPoint(x: self.view.frame.width / 2,
            y: self.view.frame.height / 8 * 6.4)
        self.view.addSubview(logInButton)

        
        // Facebook Login Button
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

