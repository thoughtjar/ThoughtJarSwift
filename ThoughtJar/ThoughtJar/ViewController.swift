//
//  ViewController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/20/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit
import Alamofire
//import Firebase
//import GoogleSignIn

class ViewController: UIViewController, UITextFieldDelegate {//}, GIDSignInUIDelegate {
    
    @IBOutlet weak var phoneNumberField: UITextField!
    var phoneNumber:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        stylePhoneNumberField()
        //NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        phoneNumberField.keyboardType = UIKeyboardType.numberPad
        self.hideKeyboardWhenTappedAround()
        self.phoneNumberField.delegate = self
        self.phoneNumberField.autocorrectionType = .no
        /*
        print(UserDefaults.standard.string(forKey: "name")==nil)
        let googleLoginButton = GIDSignInButton()
        googleLoginButton.frame = CGRect(x: (view.frame.width/2)-50, y: view.frame.height - 220, width: 135, height: 40)
        googleLoginButton.center.x = self.view.center.x
        view.addSubview(googleLoginButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
         
        -------------
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
    @IBAction func formatNumber(_ sender: Any) {
        // fix phone number
        phoneNumberField.text = formattedNumber(number: phoneNumberField.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLogin" {
            if let destinationVC = segue.destination as? LoginController {
                destinationVC.phoneNumber = self.phoneNumberField.text!
            }
        }else if segue.identifier == "showSignup" {
            if let destinationVC = segue.destination as? SignupController {
                destinationVC.phoneNumber = self.phoneNumberField.text!
            }
        }
    }
    
    private func formattedNumber(number: String) -> String {
        var cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var mask = "+X (XXX) XXX - XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask.characters {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    /*
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func stylePhoneNumberField() {
        phoneNumberField.layer.cornerRadius = 10
        //phoneNumberField.layer.borderColor = UIColor( red: 0.07, green: 0.14, blue:0.3, alpha: 1.0 ).cgColor
        phoneNumberField.layer.borderColor = UIColor.white.cgColor
        phoneNumberField.layer.borderWidth = 5
        //phoneNumberField.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        phoneNumberField.backgroundColor = UIColor.clear
        phoneNumberField.setValue(UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), forKeyPath: "_placeholderLabel.textColor")
        let _frame:CGRect = CGRect(x: 0, y: 0, width:10, height: phoneNumberField.frame.size.height)
        let paddingView = UIView(frame: _frame)
        phoneNumberField.leftView = paddingView
        phoneNumberField.leftViewMode = UITextFieldViewMode.always
        phoneNumberField.layer.masksToBounds = true
    }
    
    @IBAction func fillColor(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.phoneNumberField.backgroundColor = UIColor.white
            self.phoneNumberField.setValue(UIColor.init(red: 0.58, green: 0.62, blue: 0.72, alpha:1.0), forKeyPath: "_placeholderLabel.textColor")
            //self.phoneNumberField.layer.borderColor = UIColor.white.cgColor
            //self.phoneNumberField.textColor = UIColor.white
        }
    }
    
    @IBAction func revertColor(_ sender: Any) {
        if(self.phoneNumberField.text == ""){
            UIView.animate(withDuration: 2) {
                self.phoneNumberField.backgroundColor = UIColor.clear
                self.phoneNumberField.setValue(UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), forKeyPath: "_placeholderLabel.textColor")
                //self.phoneNumberField.layer.borderColor = UIColor.white.cgColor
                //self.phoneNumberField.textColor = UIColor.white
            }
        }
    }
    
    @IBAction func loginWithCredentials(_ sender: UIButton) {
        var unformattedNumber = ""
        let validNumbers:[String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for (index, char) in (self.phoneNumberField.text?.enumerated())! {
            if(validNumbers.contains(String(char))){
                unformattedNumber = unformattedNumber + String(char)
            }
        }
        self.phoneNumber = unformattedNumber
        let parameters: Parameters = ["phone": unformattedNumber]
        let url = "https://api.thoughtjar.net/checkUserExists"
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON {response in
            print("authenticating")
            print(response)
            var numberExists:Bool = false
            if let result = response.result.value {
                numberExists = (result as! Bool)
            }
            if(numberExists == true){
                self.performSegue(withIdentifier: "showLogin", sender: nil)
            }else{
                self.performSegue(withIdentifier: "showSignup", sender: nil)
            }
        }
    }
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
