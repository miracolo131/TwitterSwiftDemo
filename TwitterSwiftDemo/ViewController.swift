//
//  ViewController.swift
//  TwitterSwiftDemo
//
//  Created by Miracolo Bosco on 15/1/5.
//  Copyright (c) 2015年 MI-31. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

    @IBOutlet weak var LoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let logInButton = TWTRLogInButton(logInCompletion: {
//            (session: TWTRSession!, error: NSError!) in
//            // play with Twitter session
//        })
//        logInButton.center = self.view.center
//        self.view.addSubview(logInButton)
//        let testButton = UIButton(frame: CGRectMake(100, 100, 100, 100))
//        testButton.setTitle("push", forState: UIControlState.Normal)
//        testButton.backgroundColor = UIColor.blackColor()
//        testButton.addTarget(self, action: "push", forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(testButton)
        let loginButton = TWTRLogInButton(logInCompletion: {
            session, error in
            if session != nil {
                println(session.userName)
                let tweetsVC = TweetsTableViewController()
                UIApplication.sharedApplication().keyWindow?.rootViewController = tweetsVC
            } else {
                println(error.localizedDescription)
            }
        })
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)

    }

    func push(){
        println("push")
        let tweetsVC = TweetsTableViewController()
        self.navigationController?.pushViewController(tweetsVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

