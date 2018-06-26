//
//  ShortAnswerCollectionViewCell.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/25/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit

class ShortAnswerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var response: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        styleResponse()
    }
    
    func styleResponse() {
        response.layer.cornerRadius = 10
        response.layer.borderColor = UIColor( red: 0.58, green: 0.62, blue:0.72, alpha: 1.0 ).cgColor
        response.layer.borderWidth = 3
        response.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        let _frame:CGRect = CGRect(x: 0, y: 0, width:10, height: response.frame.size.height)
        let paddingView = UIView(frame: _frame)
        response.leftView = paddingView
        response.leftViewMode = UITextFieldViewMode.always
        response.layer.masksToBounds = true
    }

    @IBAction func fillColor(_ sender: Any) {
        response.backgroundColor = UIColor( red: 0, green: 0.68, blue: 0.12, alpha:1.0)
        response.layer.borderColor = UIColor( red: 0, green: 0.68, blue:0.12, alpha: 1.0 ).cgColor
        response.textColor = UIColor.white
    }
    
    @IBAction func revertColor(_ sender: Any) {
        response.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        response.layer.borderColor = UIColor( red: 0.58, green: 0.62, blue: 0.72, alpha:1.0).cgColor
        response.textColor = UIColor( red: 0.58, green: 0.62, blue:0.72, alpha: 1.0 )
    }
}