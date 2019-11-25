//
//  CourseViewController.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/25/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CourseViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    //MARK: - IBOutlets and IBActions
    @IBAction func backIcon(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var deleteRecords: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func deleteAllRecords(_ sender: Any) {
        deleteProfiles()
    }
    
    //MARK: - Private pearams
     var datasource = [User]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0));
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0));
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView?.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.borderWidth = 3
        self.tableView.layer.borderColor = UIColor.black.cgColor
        deleteButton()
        datasource = fetchProfiles()
    }
    
    //MARK: - private functions
    private func deleteButton(){
        deleteRecords.layer.borderWidth = 1
        deleteRecords.layer.cornerRadius = 5
        deleteRecords.layer.borderColor = UIColor.black.cgColor
    }
    private func fetchProfiles() -> Array<User> {
        let fetchReq: NSFetchRequest<User> = User.fetchRequest()
        let users = try! CoreDataManager.sharedInstance.managedObjectContext.fetch(fetchReq)
        if (!users.isEmpty) {
           return users.sorted(by: { $0.score > $1.score })} else {
            return users
        }
    }
    private func deleteProfile(nam : String) {
        let fetchReq: NSFetchRequest<User> = User.fetchRequest()
        let users = try! CoreDataManager.sharedInstance.managedObjectContext.fetch(fetchReq)
        
            for user in users {
                if user.name == nam {
                    CoreDataManager.sharedInstance.managedObjectContext.delete(user)
                }
            }
            datasource =  users.sorted(by: { $0.score > $1.score })
            CoreDataManager.sharedInstance.saveContext()
            datasource = fetchProfiles()
            DispatchQueue.main.async {
                let range = NSMakeRange(0, self.tableView.numberOfSections)
                let sections = NSIndexSet(indexesIn: range)
                self.tableView.reloadSections(sections as IndexSet, with: .automatic)
            }
    }
    private func deleteProfiles() {
        let fetcReq : NSFetchRequest<User> = User.fetchRequest()
        let users = try! CoreDataManager.sharedInstance.managedObjectContext.fetch(fetcReq)
        for user in users {
            CoreDataManager.sharedInstance.managedObjectContext.delete(user)
        }
            CoreDataManager.sharedInstance.saveContext()
            datasource = fetchProfiles()
            DispatchQueue.main.async {
                let range = NSMakeRange(0, self.tableView.numberOfSections)
                let sections = NSIndexSet(indexesIn: range)
                self.tableView.reloadSections(sections as IndexSet, with: .automatic)
            }
    }
}

extension CourseViewController : UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userObj:User = self.datasource[indexPath.row];
        let cell:UserCell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell;
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
            cell.scoreLabel.text = "\(userObj.score)"
            cell.rankLabel.text = "# \(indexPath.row + 1) "
            cell.nameLabel.text = userObj.name
        return cell
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0){
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
            view.backgroundColor = UIColor.clear
            
            let label1 = UILabel()
            label1.textAlignment = .center
            label1.translatesAutoresizingMaskIntoConstraints = false
            let label2 = UILabel()
            label2.textAlignment = .center
            label2.translatesAutoresizingMaskIntoConstraints = false
            let label3 = UILabel()
            label3.textAlignment = .center
            label3.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(label1)
            view.addSubview(label2)
            view.addSubview(label3)
            
            label1.attributedText = attributeStrin(myString: "Rank")
            label2.attributedText = attributeStrin(myString: "Name")
            label3.attributedText = attributeStrin(myString: "Score")
            
            label1.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            label1.widthAnchor.constraint(equalToConstant: 82).isActive = true
            label1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            label1.rightAnchor.constraint(equalTo: label2.leftAnchor, constant: 8).isActive = true
            
            label2.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            label3.leftAnchor.constraint(equalTo: label2.rightAnchor, constant: 8).isActive = true
            label3.widthAnchor.constraint(equalToConstant: 82).isActive = true
            label3.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            label3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            datasource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func attributeStrin(myString : String) -> NSAttributedString {
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Georgia", size: 25.0)! ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        return myAttrString
    }
}
