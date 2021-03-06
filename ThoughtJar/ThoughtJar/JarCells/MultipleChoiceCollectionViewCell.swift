//
//  MultipleChoiceCollectionViewCell.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/25/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit

class MultipleChoiceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var questionField: UILabel!
    var buttonCount:Int = 0
    var buttonList = [UIButton]()
    var alphabetList:[String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "BRUH UR INSANE", "ACTUALLY THO"]
    var selectedButtonTag:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func addButton(field:String){
        //print("multiplechoicecell: "+field)
        let optimalHeight = questionField.optimalHeight + 8
        let button = UIButton(frame: CGRect(x: 8, y: (optimalHeight+CGFloat(45*buttonCount)), width: 337, height: 40))
        button.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        button.layer.cornerRadius = 13
        button.setTitle(alphabetList[buttonCount] + "      " + field, for: .normal)
        let font = UIFont(name: "NHaasGroteskDSPro-55Rg", size: 16.0)
        button.titleLabel?.font = font
        button.layer.borderColor = UIColor( red: 0.58, green: 0.62, blue: 0.72, alpha:1.0).cgColor
        button.layer.borderWidth = 5
        button.setTitleColor(UIColor( red: 0.58, green: 0.62, blue: 0.72, alpha:1.0), for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.layer.masksToBounds = true;
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.tag = buttonList.count
        buttonList.append(button)
        buttonCount += 1
        /*
        for i in 0...(buttonList.count-1){
            print(buttonList[i].titleLabel?.text)
        }
        */
        self.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        UIView.animate(withDuration: 0.15){
            sender.backgroundColor = UIColor( red: 0, green: 0.68, blue: 0.12, alpha:1.0)
            sender.layer.borderColor = UIColor( red: 0, green: 0.68, blue: 0.12, alpha:1.0).cgColor
            sender.setTitleColor(UIColor.white, for: .normal)
        }
        if(selectedButtonTag != -1){
            let revertedButton:UIButton = buttonList[selectedButtonTag]
            UIView.animate(withDuration: 0.15){
                revertedButton.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
                revertedButton.layer.borderColor = UIColor( red: 0.58, green: 0.62, blue: 0.72, alpha:1.0).cgColor
                revertedButton.setTitleColor(UIColor( red: 0.58, green: 0.62, blue: 0.72, alpha:1.0), for: .normal)
            }
        }
        selectedButtonTag = sender.tag
    }
}
