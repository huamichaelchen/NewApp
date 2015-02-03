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
    
    if PFUser.currentUser() != nil {
      println("User is logged in.")
      performSegueWithIdentifier("logIn", sender: self)
    }
    
    if PFUser.currentUser() == nil {
      println("No User!")
    }
    
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
    
  }
  
  // Parse Facebook Login
  @IBAction func parseFBLogin(sender: AnyObject) {
    var user = PFUser.currentUser()
    var permissions = ["public_profile", "email", "user_friends"]
    
    PFFacebookUtils.logInWithPermissions(permissions, {
      (user: PFUser!, error: NSError!) -> Void in
      if user == nil {
        NSLog("Uh oh. The user cancelled the Facebook login.")
        
        var alert = UIAlertController(title: "Login Cancelled", message: "Really?",
          preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler:
          { action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
      } else if user.isNew {
        NSLog("User signed up and logged in through Facebook!")
        
        // grab info from facebook
        var FBSession = PFFacebookUtils.session()
        
        var accessToken = FBSession.accessTokenData.accessToken
        
        let url = NSURL(string: "https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token="+accessToken)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: { response, data, error in
          let image = UIImage(data: data)
          
          //self.profilePic.Image
          
          
          user["profile_pic"] = data
          user.save()
          
          FBRequestConnection.startForMeWithCompletionHandler({
            connection, result, error in

            user["first_name"] = result["first_name"]
            user["last_name"] = result["last_name"]
            user["email"] = result["email"]
            user["facebookID"] = result["id"]
            user["gender"] = result["gender"]
            user["locale"] = result["locale"]
            user["timezone"] = result["timezone"]
            user["fb_verified"] = result["verified"]
            user.save()
            
            println(result)
          })
        })
        
        self.performSegueWithIdentifier("logIn", sender: self)
        
      } else {
        NSLog("User logged in through Facebook!")
        self.performSegueWithIdentifier("logIn", sender: self)
      }
    })
    
  }

  
  func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
    self.performSegueWithIdentifier("logIn", sender: self)
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

