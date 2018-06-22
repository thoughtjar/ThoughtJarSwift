//
//  FillJarController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/22/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit

class FillJarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
