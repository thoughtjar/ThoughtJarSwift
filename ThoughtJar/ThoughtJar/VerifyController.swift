//
//  VerifyController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 7/2/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit
import Alamofire

class VerifyController: UIViewController, UITextFieldDelegate {

    var signUpData: [String: String] = [:]
    
    @IBOutlet weak var verMessage: UILabel!
    @IBOutlet weak var verCodeOne: UITextField!
    @IBOutlet weak var verCodeTwo: UITextField!
    @IBOutlet weak var verCodeThree: UITextField!
    @IBOutlet weak var verCodeFour: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        print("in verify controller")
        print(self.signUpData)
        
        //style text fields
        styleTextField(textField: self.verCodeOne)
        styleTextField(textField: self.verCodeTwo)
        styleTextField(textField: self.verCodeThree)
        styleTextField(textField: self.verCodeFour)
        
        //handle color changes
        self.verCodeOne.addTarget(self, action: #selector(textFieldDidBeginChange(_:)), for: UIControlEvents.editingDidBegin)
        self.verCodeTwo.addTarget(self, action: #selector(textFieldDidBeginChange(_:)), for: UIControlEvents.editingDidBegin)
        self.verCodeThree.addTarget(self, action: #selector(textFieldDidBeginChange(_:)), for: UIControlEvents.editingDidBegin)
        self.verCodeFour.addTarget(self, action: #selector(textFieldDidBeginChange(_:)), for: UIControlEvents.editingDidBegin)
        //rever colors as well
        self.verCodeOne.addTarget(self, action: #selector(textFieldDidEndChange(_:)), for: UIControlEvents.editingDidEnd)
        self.verCodeTwo.addTarget(self, action: #selector(textFieldDidEndChange(_:)), for: UIControlEvents.editingDidEnd)
        self.verCodeThree.addTarget(self, action: #selector(textFieldDidEndChange(_:)), for: UIControlEvents.editingDidEnd)
        self.verCodeFour.addTarget(self, action: #selector(textFieldDidEndChange(_:)), for: UIControlEvents.editingDidEnd)
        //switch to next number
        self.verCodeOne.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        self.verCodeTwo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        self.verCodeThree.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        self.verCodeFour.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        requestTextMessage()
    }
    
    func styleTextField(textField:UITextField) {
        textField.layer.cornerRadius = 10
        //phoneNumberField.layer.borderColor = UIColor( red: 0.07, green: 0.14, blue:0.3, alpha: 1.0 ).cgColor
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 4
        //phoneNumberField.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        textField.backgroundColor = UIColor.clear
        textField.setValue(UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), forKeyPath: "_placeholderLabel.textColor")
        //let _frame:CGRect = CGRect(x: 0, y: 0, width:10, height: 100)
        //let paddingView = UIView(frame: _frame)
        //textField.leftView = paddingView
        textField.leftViewMode = UITextFieldViewMode.always
        textField.layer.masksToBounds = true
    }
    
    func requestTextMessage() {
        let parameters: Parameters = ["phone": self.signUpData["phone"]!]
        let url = "https://api.thoughtjar.net/verifySMS"
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON {response in
            if let result = response.result.value {
                //pass
            }
        }
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
    
    @objc func textFieldDidChange(_ textfield:UITextField){
        print("textfield changed")
        print(textfield.tag)
        if(textfield.text?.count == 1){
            switch textfield{
                case verCodeOne:
                    verCodeTwo.becomeFirstResponder()
                case verCodeTwo:
                    verCodeThree.becomeFirstResponder()
                case verCodeThree:
                    verCodeFour.becomeFirstResponder()
                case verCodeFour:
                    verCodeFour.resignFirstResponder()
                default:
                    break
            }
        }
    }
    
    @IBAction func uploadSignUpData(_ sender: UIButton) {
        let verCode: String = verCodeOne.text! + verCodeTwo.text! + verCodeThree.text! + verCodeFour.text!
        print(verCode)
        let parameters: Parameters = ["phone": self.signUpData["phone"]!,
                                      "password": self.signUpData["password"]!,
                                      "fName": self.signUpData["fName"]!,
                                      "lName": self.signUpData["lName"]!,
                                      "verificationCode": verCode]
        let url = "https://api.thoughtjar.net/signUp"
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
