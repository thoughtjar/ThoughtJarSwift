//
//  ViewController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/20/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let googleLoginButton = GIDSignInButton()
        googleLoginButton.frame = CGRect(x: 10, y: view.frame.height - 60, width: view.frame.width - 20, height: 50)
        view.addSubview(googleLoginButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

