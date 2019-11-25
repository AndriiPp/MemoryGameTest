//
//  GameViewController.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/25/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit
import CoreData

class GameViewController: UIViewController {
    
    //MARK: - IBOutlets and IBActions
    @IBAction func topClick(_ sender: Any) {
        self.performSegue(withIdentifier: "showScore", sender: self)
    }
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var exit: UIButton!
    @IBAction func exitButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func resetButton(_ sender: Any) {
        self.reloadTable()
    }
    
    //MARK:- Private params
    var dataSource = [Card]()
    var selectedLabel:Int = -1;
    var selectedCounting:Int = 0;
    var scoring:Int = 0;
    var clickTime : DispatchTime? = nil;
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        self.reloadData();
        self.updateGameScore();
        changeButton()
    }
    
    //MARK: - Private functions
    private func updateGameScore() {
        self.rating.text = "\(scoring)"
    }
    
    private func changeButton(){
        rating.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        rating.layer.borderWidth = 1.0
        rating.layer.borderColor = UIColor.black.cgColor
        reset.layer.cornerRadius = 10
        exit.layer.cornerRadius = 10
        reset.layer.borderColor = UIColor.black.cgColor
        reset.layer.borderWidth = 1
        exit.layer.borderColor = UIColor.black.cgColor
         exit.layer.borderWidth = 1
    }
    
    private func reloadTable() {
        self.clickTime = nil;
        self.scoring = 0;
        self.selectedLabel = -1;
        self.selectedCounting = 0;
        self.updateGameScore();
        self.reloadData();
        self.collectionView.reloadData();
    }
    
    private func isWon() ->  Bool {
        let c1Array = self.dataSource.filter { $0.isDisabled == true }
        return c1Array.count == self.dataSource.count ? true : false;
    }
    private func reloadData() {
        if(self.dataSource.count > 0) {
            self.dataSource.removeAll();
    }
        var numbers = [1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8]
        var randomNums = [Int]()
        while numbers.count > 0 {
            let arrayKey = Int(arc4random_uniform(UInt32(numbers.count)))
            let randNum = numbers[arrayKey]
            randomNums.append(randNum)
            numbers.remove(at: arrayKey)
        }
        var index: Int  = 0;
        for i in 0 ..< 4 {
            for j in 0 ..< 4 {
                let obj:Card = Card();
                obj.position = "\(i)\(j)";
                obj.isSelected = false;
                obj.isDisabled = false;
                obj.cardType = randomNums[index]
                index += 1;
                self.dataSource.append(obj)
            }
        }
    }
    
    private func updateSelectedLabel(withCardType type:Int, isDisable:Bool ) {
        if type > 0 {
            let selectedLabelArray = self.dataSource.filter { $0.cardType == type }
            for i in 0 ..< selectedLabelArray.count {
                let object1 :Card = selectedLabelArray[i];
                object1.isDisabled = isDisable;
                object1.isSelected = isDisable;
                let Index  = self.dataSource.firstIndex(of: object1)!
                self.dataSource[Index] = object1;
                UIView.setAnimationsEnabled(false);
                self.collectionView.reloadItems(at: [NSIndexPath(row: Index, section: 0) as IndexPath]);
                UIView.setAnimationsEnabled(true);
                
            }
        }
    }

    private func showAlertVC()  {
        
        let actionVC: UIAlertController = UIAlertController(title: "You won!", message: "you want to save game data?", preferredStyle: .alert)
        let subview = (actionVC.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = UIColor(red: (42/255.0), green: (69/255.0), blue: (78/255.0), alpha: 1.0)
        let myString  = "You won!"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 20.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:myString.count))
        actionVC.setValue(myMutableString, forKey: "attributedTitle")
        
        let mesageString  = "you want to save game data?"
        var messageMutableString = NSMutableAttributedString()
        messageMutableString = NSMutableAttributedString(string: mesageString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 16.0)!])
        messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:mesageString.count))
        actionVC.setValue(messageMutableString, forKey: "attributedMessage")
        let noAction: UIAlertAction = UIAlertAction(title: "No", style: .default) { action -> Void in
            self.reloadTable();
        }
        noAction.setValue(UIColor.white, forKey: "titleTextColor")
        actionVC.addAction(noAction)
        let okAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            let nameField = actionVC.textFields![0] as UITextField
            nameField.textColor = UIColor.black
            if (!(nameField.text!.isEmpty) && (nameField.text!.count) > 0) {
                let userObj : User = CoreDataManager.sharedInstance.createEntityWithName("User") as! User;
                userObj.name = nameField.text;
                userObj.score = Int16(self.scoring);
                userObj.endDate = NSDate();
                CoreDataManager.sharedInstance.saveContext();
                self.reloadTable();
            }
            else{
                self.present(actionVC, animated: true, completion: nil)
            }
        }
        actionVC.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name"
            textField.textColor = UIColor.brown
        }
        okAction.setValue(UIColor.white, forKey: "titleTextColor")
        actionVC.addAction(okAction)
        self.present(actionVC, animated: true, completion: nil)
    }
}

extension GameViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - CollectioView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LabelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath as IndexPath) as! LabelCell
        let obj: Card = self.dataSource[indexPath.row]
        if obj.isDisabled  {
            cell.setImage("\(0)");
        } else {
            if(obj.isSelected) {
                cell.setImage("\(obj.cardType)");
            } else {
                cell.setImage("Bg");
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat = (collectionView.frame.size.width-30)/4;
        return CGSize(width: width, height: width+5);
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0,  bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (clickTime != nil) {
            if  self.selectedCounting > 2{
                return;
            } else if self.selectedCounting == 2 {
                if DispatchTime.now() < clickTime!+1 {
                    return;
                }
            }
        }
        let objec: Card = self.dataSource[indexPath.row]
        if(!objec.isSelected && !objec.isDisabled) {
            objec.isSelected = true;
            self.dataSource[indexPath.row] = objec
            clickTime = DispatchTime.now();
            self.selectedCounting += 1;
            let when = clickTime! + 1 // change 1 to desired number of seconds
            UIView.setAnimationsEnabled(false);
            self.collectionView.reloadItems(at: [indexPath]);
            UIView.setAnimationsEnabled(true);
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                if self.selectedLabel == -1 {
                    self.selectedLabel = objec.cardType;
                } else {
                    if self.selectedLabel == objec.cardType {
                        self.scoring += 2;
                        self.updateSelectedLabel(withCardType: objec.cardType, isDisable:true);
                    } else {
                        self.updateSelectedLabel(withCardType: self.selectedLabel, isDisable:false);
                        self.updateSelectedLabel(withCardType: objec.cardType, isDisable:false);
                        self.scoring -= 1;
                    }
                    self.selectedLabel = -1;
                    self.selectedCounting = 0;
                }
                self.updateGameScore();
                if self.isWon() {
                   self.showAlertVC()
                }
            })
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
