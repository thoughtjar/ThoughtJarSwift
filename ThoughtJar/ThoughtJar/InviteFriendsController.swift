//
//  InviteFriendsController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/24/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit

class InviteFriendsController: UIViewController {

    @IBOutlet weak var shareType: UISegmentedControl!
    @IBOutlet weak var shareField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //styling uisegmented controller
        self.styleShareType()
        //styling sharefield text
        self.styleShareField()
        
        // Do any additional setup after loading the view.
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
    
}
