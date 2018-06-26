//
//  JarCollectionViewCell.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/21/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit

class JarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var jarTitle: UILabel!
    @IBOutlet weak var jarDescription: UILabel!
    @IBOutlet weak var jarCreator: UILabel!
    @IBOutlet weak var jarNumQuestions: UILabel!
    @IBOutlet weak var jarMoneyAmt: UILabel!
    @IBOutlet weak var jarBorder: UIImageView!
    @IBOutlet weak var darkAuthorIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
