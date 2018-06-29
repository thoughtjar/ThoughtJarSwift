//
//  ProfileController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/22/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit
//import GoogleSignIn

class ProfileController: UIViewController { //, GIDSignInUIDelegate {

    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        print("entering profile controller")
        userName.text = (UserDefaults.standard.string(forKey: "fName"))! + " " + (UserDefaults.standard.string(forKey: "lName"))!
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        print("logging out")
        UserDefaults.standard.removeObject(forKey: "fName")
        UserDefaults.standard.removeObject(forKey: "lName")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "access-token")
        //GIDSignIn.sharedInstance()?.signOut()
        
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! ViewController
        //self.present(vc, animated: true, completion: nil)
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func withdrawMoney(_ sender: UIButton) {
        print("withdrawing money")
    }
    
    @IBAction func showInviteFriends(_ sender: UIButton) {
        performSegue(withIdentifier: "showInviteFriends", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
