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
        print(UserDefaults.standard.string(forKey: "name")==nil)
        let googleLoginButton = GIDSignInButton()
        googleLoginButton.frame = CGRect(x: (view.frame.width/2)-50, y: view.frame.height - 220, width: 135, height: 40)
        googleLoginButton.center.x = self.view.center.x
        view.addSubview(googleLoginButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        /*
        if(UserDefaults.standard.string(forKey: "name")==nil){
            // Do any additional setup after loading the view, typically from a nib.
            let googleLoginButton = GIDSignInButton()
            googleLoginButton.frame = CGRect(x: (view.frame.width/2)-50, y: view.frame.height - 220, width: 135, height: 40)
            googleLoginButton.center.x = self.view.center.x
            view.addSubview(googleLoginButton)
            
            GIDSignIn.sharedInstance().uiDelegate = self
            //GIDSignIn.sharedInstance().signIn()
        }else{
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = kCATransitionFade
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "navController") as! UINavigationController
            self.present(vc, animated: false, completion: nil)
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }

}

