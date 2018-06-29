//
//  LoginController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/28/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController, UITextFieldDelegate {

    var phoneNumber:String = ""
    
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //retrieve data from root view controller
        self.phoneNumberField.text = self.phoneNumber
        
        //set textfield delegates
        self.hideKeyboardWhenTappedAround()
        self.phoneNumberField.delegate = self
        self.passwordField.delegate = self
        
        //style textfields
        styleTextField(textField: self.passwordField)
        self.phoneNumberField.layer.cornerRadius = 10
        self.phoneNumberField.layer.borderColor = UIColor.white.cgColor
        self.phoneNumberField.layer.borderWidth = 3
        let _frame:CGRect = CGRect(x: 0, y: 0, width:10, height: phoneNumberField.frame.size.height)
        let paddingView = UIView(frame: _frame)
        self.phoneNumberField.leftView = paddingView
        self.phoneNumberField.leftViewMode = UITextFieldViewMode.always
        self.phoneNumberField.layer.masksToBounds = true
        self.phoneNumberField.keyboardType = UIKeyboardType.numberPad
        
        //handle color changes
        self.passwordField.addTarget(self, action: #selector(textFieldDidBeginChange(_:)), for: UIControlEvents.editingDidBegin)
        //rever colors as well
        self.passwordField.addTarget(self, action: #selector(textFieldDidEndChange(_:)), for: UIControlEvents.editingDidEnd)
    }

    func styleTextField(textField:UITextField) {
        textField.layer.cornerRadius = 10
        //phoneNumberField.layer.borderColor = UIColor( red: 0.07, green: 0.14, blue:0.3, alpha: 1.0 ).cgColor
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 4
        //phoneNumberField.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        textField.backgroundColor = UIColor.clear
        textField.setValue(UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), forKeyPath: "_placeholderLabel.textColor")
        let _frame:CGRect = CGRect(x: 0, y: 0, width:10, height: phoneNumberField.frame.size.height)
        let paddingView = UIView(frame: _frame)
        textField.leftView = paddingView
        textField.leftViewMode = UITextFieldViewMode.always
        textField.layer.masksToBounds = true
    }
    
    @objc func textFieldDidBeginChange(_ textfield:UITextField){
        UIView.animate(withDuration: 0.2) {
            textfield.backgroundColor = UIColor.white
            textfield.setValue(UIColor.init(red: 0.58, green: 0.62, blue: 0.72, alpha:1.0), forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    @objc func textFieldDidEndChange(_ textfield:UITextField){
        if(textfield.text == ""){
            UIView.animate(withDuration: 0.2) {
                textfield.backgroundColor = UIColor.clear
                textfield.setValue(UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), forKeyPath: "_placeholderLabel.textColor")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
        //self.view.endEditing(true)
        //return false
    }
    
    @IBAction func logInWithCredentials(_ sender: UIButton) {
        var unformattedNumber = ""
        let validNumbers:[String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for (index, char) in (self.phoneNumberField.text?.enumerated())! {
            print(char)
            print(String(char))
            if(validNumbers.contains(String(char))){
                print("this is a number")
                unformattedNumber = unformattedNumber + String(char)
            }
        }
        self.phoneNumber = unformattedNumber
        let parameters: Parameters = ["phone": unformattedNumber,
                                      "password": self.passwordField.text!]
        let url = "https://api.thoughtjar.net/login"
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON {response in
            if let result = response.result.value {
                print(result)
                let JSON = result as! NSDictionary
                UserDefaults.standard.set((JSON["access-token"])!, forKey: "access-token")
                UserDefaults.standard.set((JSON["phone"])!, forKey: "phone")
                UserDefaults.standard.set((JSON["fName"])!, forKey: "fName")
                UserDefaults.standard.set((JSON["lName"])!, forKey: "lName")
            }
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = kCATransitionFade
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "navController") as! UINavigationController
            self.present(vc, animated: false, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
