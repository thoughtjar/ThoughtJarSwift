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

class JarListController: UIViewController, UIViewControllerTransitioningDelegate {

    let JarCollectionViewCellId: String = "JarCollectionViewCell"
    @IBOutlet weak var JarListCollectionView: UICollectionView!
    
    var jarDataList = [jarData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: JarCollectionViewCellId, bundle: nil)
        JarListCollectionView.register(nibCell, forCellWithReuseIdentifier: JarCollectionViewCellId)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = ["access-token": UserDefaults.standard.string(forKey: "access-token")]
        Alamofire.request("https://api.thoughtjar.net/fillJars", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
            if let result = response.result.value {
                
                let JSON = (result as! NSDictionary)
                let jars = JSON["jars"] as! NSArray
                print(jars[0])
                //print(inJSON[0])
                //print((JSON["jars"])[0])
                for i in 0...(jars.count-1){
                    let jar = jars[i] as! NSDictionary
                    //print(jar["title"] as! String)
                    self.jarDataList.append(jarData(jarTitle: (jar["title"] as! String), jarDescription: jar["description"] as! String, jarCreator: "Dave", jarNumQuestions: "3", jarMoneyAmt: "$1.50"))
                }
                self.JarListCollectionView.reloadData()
            }
        }

        /*
        jarDataList = [jarData(jarTitle: "Title 1", jarDescription: "Descr 1", jarCreator: "Creator 1", jarNumQuestions: "2",                               jarMoneyAmt: "1.00"),
                       jarData(jarTitle: "Title 2", jarDescription: "Descr 2", jarCreator: "Creator 2", jarNumQuestions: "4", jarMoneyAmt: "2.00"),
                       jarData(jarTitle: "Title 3", jarDescription: "Descr 3", jarCreator: "Creator 3", jarNumQuestions: "3", jarMoneyAmt: "3.00")]
        (/
        */
 
        print("in jar list controller")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension JarListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        return CGSize.init(width: UIScreen.main.bounds.width - 20, height: 112)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
}
