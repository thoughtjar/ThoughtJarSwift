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
    var selectedButtonTag:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func addButton(field:String){
        //print("multiplechoicecell: "+field)
        let button = UIButton(frame: CGRect(x: 8, y: 20+(30*buttonCount), width: 330, height: 30))
        button.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        button.layer.cornerRadius = 10
        button.setTitle(field, for: .normal)
        let font = UIFont(name: "NHaasGroteskDSPro-65Md", size: 16.0)
        button.titleLabel?.font = font
        button.layer.borderColor = UIColor( red: 0.58, green: 0.62, blue: 0.72, alpha:1.0).cgColor
        button.layer.borderWidth = 3
        button.setTitleColor(UIColor( red: 0.58, green: 0.62, blue: 0.72, alpha:1.0), for: .normal)
        button.layer.masksToBounds = true;
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.tag = buttonList.count
        buttonList.append(button)
        /*
        for i in 0...(buttonList.count-1){
            print(buttonList[i].titleLabel?.text)
        }
        */
        if(buttonList.count == 1){
            print(button.titleLabel?.text)
            self.addSubview(button)
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        sender.backgroundColor = UIColor( red: 0, green: 0.68, blue: 0.12, alpha:1.0)
        sender.layer.borderColor = UIColor( red: 0, green: 0.68, blue: 0.12, alpha:1.0).cgColor
        sender.setTitleColor(UIColor.white, for: .normal)
        if(selectedButtonTag != -1){
            let revertedButton:UIButton = buttonList[selectedButtonTag]
            revertedButton.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
            revertedButton.layer.borderColor = UIColor( red: 0.58, green: 0.62, blue: 0.72, alpha:1.0).cgColor
            revertedButton.setTitleColor(UIColor( red: 0.58, green: 0.62, blue: 0.72, alpha:1.0), for: .normal)
        }
    }
}
