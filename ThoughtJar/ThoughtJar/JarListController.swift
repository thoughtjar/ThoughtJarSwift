//
//  JarListController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/21/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit
import Alamofire

struct jarData {
    let jarTitle : String!
    let jarDescription: String!
    let jarCreator: String!
    let jarNumQuestions: String!
    let jarMoneyAmt: String!
}

class JarListController: UIViewController  {

    let JarCollectionViewCellId: String = "JarCollectionViewCell"
    @IBOutlet weak var JarListCollectionView: UICollectionView!
    
    //var origin = CGPoint(x:322,y:29)
    
    var jarDataList = [jarData]()
    var refresher:UIRefreshControl!
    var jarIdentifiers = [String]()
    var clickedCellIdentifer: String = ""
    //let transition = BubbleTransition()
    
    @IBAction func openProfile(_ sender: UIButton) {
        //performSegue(withIdentifier: "showProfile", sender: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileNavController") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
    }

    @objc func refreshStream(_ sender: Any) {
        
        print("refresh")
        //self.collectionView?.reloadData()
        getJars()
        //refreshControl?.endRefreshing()
        let when = DispatchTime.now() + 1.0 // change to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.refresher.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showJar" {
            if let destinationVC = segue.destination as? FillJarController {
                destinationVC.identifier = self.clickedCellIdentifer
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        let nibCell = UINib(nibName: JarCollectionViewCellId, bundle: nil)
        JarListCollectionView.register(nibCell, forCellWithReuseIdentifier: JarCollectionViewCellId)
        
        self.refresher = UIRefreshControl()
        self.refresher.tintColor = UIColor(red: 0.07, green: 0.14, blue:0.30, alpha:1.0)
        self.refresher.addTarget(self, action: #selector(refreshStream(_:)), for: .valueChanged)
        JarListCollectionView.refreshControl = self.refresher
        
        
        getJars()
        print(self.jarIdentifiers)
        print("in jar list controller")
    }
    
    func getJars(){
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
                    self.jarIdentifiers.append(jar["identifier"] as! String)
                }
                self.JarListCollectionView.reloadData()
            }
        }
    }

}


extension JarListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jarDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = Bundle.main.loadNibNamed("JarCollectionViewCell", owner: self, options: nil) as! JarCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JarCollectionViewCellId, for: indexPath) as! JarCollectionViewCell
        //print(jarDataList)
        //print("1")
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
        /*
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        */
        //get cell identifer
        self.clickedCellIdentifer = self.jarIdentifiers[indexPath.item]
        performSegue(withIdentifier: "showJar", sender: nil)
    }
    

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? JarCollectionViewCell {
                cell.jarTitle.alpha = CGFloat(0.4)
                cell.jarDescription.alpha = CGFloat(0.4)
                cell.jarCreator.alpha = CGFloat(0.4)
                cell.jarNumQuestions.alpha = CGFloat(0.4)
                cell.jarMoneyAmt.alpha = CGFloat(0.4)
                cell.jarBorder.alpha = CGFloat(0.4)
                cell.darkAuthorIcon.alpha = CGFloat(0.4)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? JarCollectionViewCell {
                cell.jarTitle.alpha = CGFloat(1)
                cell.jarDescription.alpha = CGFloat(1)
                cell.jarCreator.alpha = CGFloat(1)
                cell.jarNumQuestions.alpha = CGFloat(1)
                cell.jarMoneyAmt.alpha = CGFloat(1)
                cell.jarBorder.alpha = CGFloat(1)
                cell.darkAuthorIcon.alpha = CGFloat(1)
            }
        }
    }
    
}
