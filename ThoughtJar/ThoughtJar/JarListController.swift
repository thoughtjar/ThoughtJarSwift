//
//  JarListController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/21/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit
import Alamofire
import BubbleTransition

struct jarData {
    let jarTitle : String!
    let jarDescription: String!
    let jarCreator: String!
    let jarNumQuestions: String!
    let jarMoneyAmt: String!
}

class JarListController: UIViewController, UIViewControllerTransitioningDelegate {

    let JarCollectionViewCellId: String = "JarCollectionViewCell"
    @IBOutlet weak var JarListCollectionView: UICollectionView!
    
    var origin = CGPoint(x:322,y:29)
    
    var jarDataList = [jarData]()
    
    let transition = BubbleTransition()
    
    @IBAction func openProfile(_ sender: UIButton) {
        performSegue(withIdentifier: "showProfile", sender: nil)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showProfile"){
            let controller = segue.destination
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
        }
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = self.origin
        transition.bubbleColor = JarListCollectionView.backgroundColor!
        transition.duration = 0.2
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = self.origin
        transition.bubbleColor = JarListCollectionView.backgroundColor!
        transition.duration = 0.2
        return transition
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: JarCollectionViewCellId, bundle: nil)
        JarListCollectionView.register(nibCell, forCellWithReuseIdentifier: JarCollectionViewCellId)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = ["access-token": UserDefaults.standard.string(forKey: "access-token")]
        let url = "https://api.thoughtjar.net/fillJars"
        //let url = "http://localhost:5000/fillJars"
        //let url = "http://198.168.1.2:5000/fillJars"
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
            if let result = response.result.value {
                
                let JSON = (result as! NSDictionary)
                let jars = JSON["jars"] as! NSArray
                print(jars[0])
                //print(inJSON[0])
                //print((JSON["jars"])[0])
                for i in 0...(jars.count-1){
                    let jar = jars[i] as! NSDictionary
                    //print(jar["title"] as! String)
                    self.jarDataList.append(jarData(jarTitle: (jar["title"] as! String), jarDescription: jar["description"] as! String, jarCreator: "Dave", jarNumQuestions: "0/20", jarMoneyAmt: "$ 10.50"))
                }
                self.JarListCollectionView.reloadData()
            }
        }

        print("in jar list controller")
    }
    

}


extension JarListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jarDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = Bundle.main.loadNibNamed("JarCollectionViewCell", owner: self, options: nil) as! JarCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JarCollectionViewCellId, for: indexPath) as! JarCollectionViewCell
        print(jarDataList)
        print("1")
        cell.jarTitle.text = jarDataList[indexPath.item].jarTitle
        cell.jarDescription.text = jarDataList[indexPath.item].jarDescription
        cell.jarCreator.text = jarDataList[indexPath.item].jarCreator
        cell.jarNumQuestions.text = jarDataList[indexPath.item].jarNumQuestions
        cell.jarMoneyAmt.text = jarDataList[indexPath.item].jarMoneyAmt
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = 10
        return UIEdgeInsetsMake(CGFloat(inset), CGFloat(inset), CGFloat(inset), CGFloat(inset))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width - 30, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JarCollectionViewCellId, for: indexPath) as! JarCollectionViewCell
        //self.origin = cell.center
        print(self.origin)
        performSegue(withIdentifier: "showJar", sender: nil)
    }
    
}
