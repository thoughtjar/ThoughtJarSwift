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
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var value: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        value.text = String(Int(slider.value+0.5))
        //value.sizeToFit()
    }
}
