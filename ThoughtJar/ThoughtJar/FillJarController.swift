//
//  FillJarController.swift
//  ThoughtJar
//
//  Created by Dave Ho on 6/22/18.
//  Copyright © 2018 Thought Jar. All rights reserved.
//

import UIKit
import Alamofire


struct shortAnswerData {
    let questionField : String!
}

struct longAnswerData {
    let questionField : String!
}

struct multipleChoiceData {
    let questionField : String!
    let options : [String]!
}

struct numberAnswerData {
    let questionField : String!
}

struct submitButtonData {
}

class FillJarController: UIViewController {

    let QuestionCollectionViewCellId: String = "JarCollectionViewCell"
    let ShortAnswerCollectionViewCellId: String = "ShortAnswerCollectionViewCell"
    let LongAnswerCollectionViewCellId: String = "LongAnswerCollectionViewCell"
    let NumberAnswerCollectionViewCellId: String = "NumberAnswerCollectionViewCell"
    let MultipleChoiceCollectionViewCellId: String = "MultipleChoiceCollectionViewCell"
    let SubmitButtonCollectionViewCellId: String = "SubmitButtonCollectionViewCell"
    var identifier: String = ""
    var questionTypes = [String]()
    
    @IBOutlet weak var QuestionListCollectionView: UICollectionView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var jarTitleLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var jarTitle: UILabel!
    
    let maxHeaderHeight: CGFloat = 110;
    let minHeaderHeight: CGFloat = 40;
    
    var previousScrollOffset: CGFloat = 0;
    
    var questionDataList = [Any]()
    
    var initialLeftBorder:CGFloat = 0.0;
    var length: CGFloat = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.hideKeyboardWhenTappedAround()
        print("identifier= "+self.identifier as! String)
        self.initialLeftBorder = jarTitleLeftConstraint.constant
        self.length = (UIScreen.main.bounds.width/2.0)-(self.jarTitle.intrinsicContentSize.width/4.0)-self.initialLeftBorder
        //jarTitle.sizeToFit()
        
        let nibCell = UINib(nibName: QuestionCollectionViewCellId, bundle: nil)
        QuestionListCollectionView.register(nibCell, forCellWithReuseIdentifier: QuestionCollectionViewCellId)
        
        let shortAnswerNibCell = UINib(nibName: ShortAnswerCollectionViewCellId, bundle: nil)
        QuestionListCollectionView.register(shortAnswerNibCell, forCellWithReuseIdentifier: ShortAnswerCollectionViewCellId)
        
        let longAnswerNibCell = UINib(nibName: LongAnswerCollectionViewCellId, bundle: nil)
        QuestionListCollectionView.register(longAnswerNibCell, forCellWithReuseIdentifier: LongAnswerCollectionViewCellId)
        
        let multipleChoiceNibCell = UINib(nibName: MultipleChoiceCollectionViewCellId, bundle: nil)
        QuestionListCollectionView.register(multipleChoiceNibCell, forCellWithReuseIdentifier: MultipleChoiceCollectionViewCellId)
        
        let numberAnswerNibCell = UINib(nibName: NumberAnswerCollectionViewCellId, bundle: nil)
        QuestionListCollectionView.register(numberAnswerNibCell, forCellWithReuseIdentifier: NumberAnswerCollectionViewCellId)
        
        let submitButtonNibCell = UINib(nibName: SubmitButtonCollectionViewCellId, bundle: nil)
        QuestionListCollectionView.register(submitButtonNibCell, forCellWithReuseIdentifier: SubmitButtonCollectionViewCellId)
        
        getQuestions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.headerHeightConstraint.constant = self.maxHeaderHeight
        updateHeader()
    }
    
    @IBAction func dismissJar(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getQuestions() {
        let parameters: Parameters = ["identifier": self.identifier,
                                      "magictoken": false]
        let url = "https://api.thoughtjar.net/fillJar"
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
            if let result = response.result.value {
                
                let JSON = (result as! NSDictionary)
                let surveyData = (JSON["surveyData"] as! NSDictionary)
                let questions = surveyData["questionList"] as! NSArray
                for i in 0...(questions.count-1){
                    let question = questions[i] as! NSDictionary
                    //print(jar["title"] as! String)
                    print(question["questionType"] as! String)
                    if((question["questionType"] as! String)=="shortanswer"){
                        self.questionDataList.append(shortAnswerData(questionField: (question["questionField"] as! String)))
                        print(shortAnswerData(questionField: (question["questionField"] as! String)))
                        self.questionTypes.append("shortanswer")
                    }else if ((question["questionType"] as! String)=="multiplechoice"){
                        let mcOptions = question["answerOptions"] as! [String]
                        self.questionDataList.append(multipleChoiceData(questionField: (question["questionField"] as! String), options: mcOptions))
                        self.questionTypes.append("multiplechoice")
                    }else if ((question["questionType"] as! String)=="numberanswer"){
                        self.questionDataList.append(numberAnswerData(questionField: (question["questionField"] as! String)))
                        self.questionTypes.append("numberanswer")
                    }else if ((question["questionType"] as! String)=="longanswer"){
                        self.questionDataList.append(longAnswerData(questionField: (question["questionField"] as! String)))
                        self.questionTypes.append("longanswer")
                    }
                }
                self.questionDataList.append(submitButtonData())
                self.questionTypes.append("submitbutton")
                self.QuestionListCollectionView.reloadData()
            }
        }
    }
}

extension FillJarController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionDataList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (self.questionTypes[indexPath.item] == "shortanswer"){
            print("yes short answer")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortAnswerCollectionViewCellId, for: indexPath) as! ShortAnswerCollectionViewCell
            cell.questionField.text = String(indexPath.item + 1) + ". " + (questionDataList[indexPath.item] as! shortAnswerData).questionField
            cell.questionField.frame = CGRect(x: cell.questionField.frame.origin.x, y: cell.questionField.frame.origin.y, width: cell.questionField.frame.width, height: cell.questionField.optimalHeight)
            return cell
        }else if(self.questionTypes[indexPath.item] == "longanswer"){
            print("yes long answer")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LongAnswerCollectionViewCellId, for: indexPath) as! LongAnswerCollectionViewCell
            cell.questionField.text = String(indexPath.item + 1) + ". " + (questionDataList[indexPath.item] as! longAnswerData).questionField
            cell.questionField.frame = CGRect(x: cell.questionField.frame.origin.x, y: cell.questionField.frame.origin.y, width: cell.questionField.frame.width, height: cell.questionField.optimalHeight)
            return cell
        }else if (self.questionTypes[indexPath.item] == "multiplechoice"){
            print("yes multiple choice")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleChoiceCollectionViewCellId, for: indexPath) as! MultipleChoiceCollectionViewCell
            cell.questionField.text = String(indexPath.item + 1) + ". " + (questionDataList[indexPath.item] as! multipleChoiceData).questionField
            cell.questionField.frame = CGRect(x: cell.questionField.frame.origin.x, y: cell.questionField.frame.origin.y, width: cell.questionField.frame.width, height: cell.questionField.optimalHeight)
            for i in 0...((questionDataList[indexPath.item] as! multipleChoiceData).options.count - 1){
                //print((questionDataList[indexPath.item] as! multipleChoiceData).options[i])
                cell.addButton(field: (questionDataList[indexPath.item] as! multipleChoiceData).options[i])
            }
            return cell
        }else if (self.questionTypes[indexPath.item] == "numberanswer"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberAnswerCollectionViewCellId, for: indexPath) as! NumberAnswerCollectionViewCell
            print("aaaaaa" + (questionDataList[indexPath.item] as! numberAnswerData).questionField)
            cell.questionField.text = String(indexPath.item + 1) + ". " + (questionDataList[indexPath.item] as! numberAnswerData).questionField
            cell.questionField.frame = CGRect(x: cell.questionField.frame.origin.x, y: cell.questionField.frame.origin.y, width: cell.questionField.frame.width, height: cell.questionField.optimalHeight)
            return cell
        }else if(self.questionTypes[indexPath.item] == "submitbutton"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubmitButtonCollectionViewCellId, for: indexPath) as! SubmitButtonCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
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
        print("cell dimensions")
        //print(indexPath.)
        if(questionTypes[indexPath.item]=="shortanswer"){
            print("shortanswerrrrrr")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                ShortAnswerCollectionViewCellId, for: indexPath) as! ShortAnswerCollectionViewCell
            print("lshorrrrrttasdnafea")
            cell.questionField.text = String(indexPath.item + 1) + ". " + (questionDataList[indexPath.item] as! shortAnswerData).questionField
            let optimalHeight = cell.questionField.optimalHeight
            return CGSize.init(width: UIScreen.main.bounds.width - 20, height: 72+(optimalHeight-26.5))
        }else if(questionTypes[indexPath.item]=="multiplechoice"){
            print("entering multiple choice dimensions")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleChoiceCollectionViewCellId, for: indexPath) as! MultipleChoiceCollectionViewCell
            cell.questionField.text = String(indexPath.item + 1) + ". " + (questionDataList[indexPath.item] as! multipleChoiceData).questionField
            let optimalHeight = cell.questionField.optimalHeight
            let _height = optimalHeight + 8.0 + CGFloat((questionDataList[indexPath.item] as! multipleChoiceData).options.count * 45)
            return CGSize.init(width: UIScreen.main.bounds.width - 20, height: _height)
        }else if(questionTypes[indexPath.item]=="numberanswer"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberAnswerCollectionViewCellId, for: indexPath) as! NumberAnswerCollectionViewCell
            cell.questionField.text = String(indexPath.item + 1) + ". " + (questionDataList[indexPath.item] as! numberAnswerData).questionField
            let optimalHeight = cell.questionField.optimalHeight
            return CGSize.init(width: UIScreen.main.bounds.width - 30, height: 96+(optimalHeight-26.5))
        }else if(questionTypes[indexPath.item]=="longanswer"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LongAnswerCollectionViewCellId, for: indexPath) as! LongAnswerCollectionViewCell
            cell.questionField.text = String(indexPath.item + 1) + ". " + (questionDataList[indexPath.item] as! longAnswerData).questionField
            let optimalHeight = cell.questionField.optimalHeight
            return CGSize.init(width: UIScreen.main.bounds.width - 20, height: 121+(optimalHeight-26.5))
        }else if(questionTypes[indexPath.item]=="submitbutton"){
            return CGSize.init(width: 130.0, height: 41.0)
        }
        print("successful")
        return CGSize.init(width: 0, height: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked some cell")
        if(questionTypes[indexPath.item]=="submitbutton"){
            var responseData: [String:String] = [:]
            print("you clicked the submit button")
            for i in 0...(questionTypes.count-1){
                /*
                print("unooooooo")
                var index:IndexPath = IndexPath(item: i, section: 1)
                print("dosssssss")
                print(index.item)
                */
                if(questionTypes[i]=="shortanswer"){
                    let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! ShortAnswerCollectionViewCell
                    responseData["Question"+String(i+1)] = cell.response.text
                }else if(questionTypes[i]=="longanswer"){
                    let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! LongAnswerCollectionViewCell
                    responseData["Question"+String(i+1)] = cell.response.text
                }else if(questionTypes[i]=="multiplechoice"){
                    let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! MultipleChoiceCollectionViewCell
                    responseData["Question"+String(i+1)] = (questionDataList[i] as! multipleChoiceData).options[cell.selectedButtonTag]
                }else if(questionTypes[i]=="numberanswer"){
                    let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! NumberAnswerCollectionViewCell
                    responseData["Question"+String(i+1)] = cell.value.text
                }
            }
            let parameters: Parameters = ["access-token": UserDefaults.standard.string(forKey: "access-token"),
                                          "response": responseData,
                                          "surveyId": self.identifier]
            let url = "https://api.thoughtjar.net/respond"
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
                if let result = response.result.value {
                    print(result)
                }
            }
        }
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        if canAnimateHeader(scrollView) {
            // Calculate new header height
            var newHeight = self.headerHeightConstraint.constant
            if isScrollingDown {
                newHeight = max(self.minHeaderHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
            }
            //print(newHeight)
            
            // Header needs to animate
            if newHeight != self.headerHeightConstraint.constant {
                //print("newHeight != self.headerHeightConstraint.constant")
                self.headerHeightConstraint.constant = newHeight
                self.updateHeader()
                self.setScrollPosition(self.previousScrollOffset)
            }
            
            self.previousScrollOffset = scrollView.contentOffset.y
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidStopScrolling() {
        print("scroll view stopped scrolling")
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)
        
        if self.headerHeightConstraint.constant > midPoint {
            self.expandHeader()
        } else {
            self.collapseHeader()
        }
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        // Calculate the size of the scrollView when header is collapsed
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight
        
        // Make sure that when header is collapsed, there is still room to scroll
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func collapseHeader() {
        print("collapsing header")
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func setScrollPosition(_ position: CGFloat) {
        self.QuestionListCollectionView.contentOffset = CGPoint(x: self.QuestionListCollectionView.contentOffset.x, y: position)
    }
    
    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.headerHeightConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
        print(self.initialLeftBorder)
        //self.titleTopConstraint.constant = -openAmount + 10
        //self.jarTitle.alpha = percentage
        self.jarTitleLeftConstraint.constant = self.initialLeftBorder + (self.length*(1.0-percentage))
        self.jarTitle.font = self.jarTitle.font.withSize(40-(20*(1.0-percentage)))
        //self.titleTop.alpha = titleTopPercentage
    }
    
}
