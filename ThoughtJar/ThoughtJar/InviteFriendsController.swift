//
//  InviteFriendsController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/24/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit

class InviteFriendsController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var shareType: UISegmentedControl!
    @IBOutlet weak var shareField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //styling uisegmented controller
        self.styleShareType()
        //styling sharefield text
        self.styleShareField()
        
        // Do any additional setup after loading the view.
        shareField.delegate = self
    }
    
    
    //styling uisegmented controller
    func styleShareType() {
        shareType.layer.cornerRadius = 10
        shareType.layer.borderColor = UIColor( red: 0.07, green: 0.14, blue:0.3, alpha: 1.0 ).cgColor
        shareType.layer.borderWidth = 3
        shareType.layer.masksToBounds = true;
        let font = UIFont(name: "NHaasGroteskDSPro-65Md", size: 16.0)
        shareType.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
    }
    
    func styleShareField() {
        shareField.layer.cornerRadius = 10
        shareField.layer.borderColor = UIColor( red: 0.07, green: 0.14, blue:0.3, alpha: 1.0 ).cgColor
        shareField.layer.borderWidth = 3
        shareField.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        let _frame:CGRect = CGRect(x: 0, y: 0, width:10, height: shareField.frame.size.height)
        let paddingView = UIView(frame: _frame)
        shareField.leftView = paddingView
        shareField.leftViewMode = UITextFieldViewMode.always
        shareField.layer.masksToBounds = true
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
    
    @IBAction func formatNumber(_ sender: Any) {
        print("value of text field is changing")
        if(shareType.selectedSegmentIndex==1){
            print("on text")
            shareField.text = formattedNumber(number: shareField.text!)
        }
    }
    
    @IBAction func shareTypeChanged(_ sender: Any) {
        //handle segmented ui controller value change
        shareField.text = ""
        if(shareType.selectedSegmentIndex==0){
            shareField.placeholder = "youremail@gmail.com"
            shareField.keyboardType = UIKeyboardType.emailAddress
        }else if(shareType.selectedSegmentIndex==1){
            shareField.placeholder = "+1 (408) 123 - 4567"
            shareField.keyboardType = UIKeyboardType.numberPad
        }
    }
    
    
    @IBAction func submitShare(_ sender: UIButton) {
        //handle press submit button here
        print("pressed submit share button")
    }
    
}
