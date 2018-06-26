//
//  ShortAnswerCollectionViewCell.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/25/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit

class ShortAnswerCollectionViewCell: UICollectionViewCell, UITextViewDelegate {

    @IBOutlet weak var questionField: UILabel!
    
    @IBOutlet weak var response: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        styleResponse()
        self.response.delegate = self
    }
    
    func styleResponse() {
        response.layer.cornerRadius = 13
        response.layer.borderColor = UIColor( red: 0.58, green: 0.62, blue:0.72, alpha: 1.0 ).cgColor
        response.layer.borderWidth = 5
        response.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        response.textColor = UIColor( red: 0.58, green: 0.62, blue:0.72, alpha: 1.0 )
        let insets = UIEdgeInsetsMake(8, 8, 8, 8)
        response.textContainerInset = insets
        response.layer.masksToBounds = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.15) {
            self.response.backgroundColor = UIColor( red: 0, green: 0.68, blue: 0.12, alpha:1.0)
            self.response.layer.borderColor = UIColor( red: 0, green: 0.68, blue:0.12, alpha: 1.0 ).cgColor
            self.response.textColor = UIColor.white
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.15){
            self.response.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
            self.response.layer.borderColor = UIColor( red: 0.58, green: 0.62, blue: 0.72, alpha:1.0).cgColor
            self.response.textColor = UIColor( red: 0.07, green: 0.14, blue:0.3, alpha: 1.0 )
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
