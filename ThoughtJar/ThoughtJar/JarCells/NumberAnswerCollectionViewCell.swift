//
//  NumberAnswerCollectionViewCell.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/25/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit

class NumberAnswerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var questionField: UILabel!
    
    var value:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*
        let slider = Slider()
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 3) as NSNumber) ?? ""
            return NSAttributedString(string: string)
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "0"))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: "3"))
        slider.fraction = 0.5
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        slider.valueViewColor = .black
        slider.frame.origin.x = 8
        slider.frame.origin.y = 40
        self.addSubview(slider)
        */
    }
}
