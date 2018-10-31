//
//  SnagTableViewController.swift
//  Snag1
//
///////////////Notes////////////////////////////
//
//   TODO:
//
//Add Title Not NIL validation
//
//
////////////////////////////////////////////////
//  Created by Eugene Trumpelmann on 2018/10/31.
//  Copyright © 2018 Eugene Trumpelmann. All rights reserved.
//

import UIKit
import RealmSwift

class SnagTableViewController: SwipeTableViewController {
    
    //MARK: - Class Initializers
    let realm = try! Realm()
    var snags : Results<Snag>?
    ///////////////////////////////
    
    
    //MARK: - View Load Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    ///////////////////////////////
    
    
    //MARK: - Data Manipulation Methods (CRUD in Realm)
    /////////////////////////////////////////////////////
    //Reading Data
    func loadData(){
        
        snags = realm.objects(Snag.self)
        tableView.reloadData()
        
    }
    
    //Create and Update Data
    func saveData(fromNewSnag snag: Snag){
        
        do{
            try realm.write {
                realm.add(snag)
            }
            
        }catch{
            print("Error saving data with: \(error)")
        }
        tableView.reloadData()
    }
    
    //Delete Data
    override func updateModel(at indexpath: IndexPath) {
        
        if let snagForDeletion = self.snags?[indexpath.row] {
            
            do{
                try self.realm.write {
                    self.realm.delete(snagForDeletion)
                }
            }catch{
                print("Error deleting with: \(error)")
            }
        }
    }
    ////////////////////////////////////////////////////////
    
    
    //MARK: - TableView Setup
    ///////////////////////////
    //Cell Setup
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let snags = snags?[indexPath.row]{
            cell.textLabel?.text = snags.title
            cell.detailTextLabel?.text = snags.detail
        }else{
            cell.textLabel?.text = "Add a new Snag..."
        }
        return cell
    }
    
    //TableView Bounds setup
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snags?.count ?? 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    ////////////////////////////
    
    
    //MARK: - Button Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
//        //Define Superscope textfields for alert fields
//        var titleField = UITextField()
//        var detailField = UITextField()
//
//        //Define Alert Controller and options
//        let alert = UIAlertController(title: "Add New Snag", message: "", preferredStyle: .alert)
//
//        //Add Title & Detail fields To Alert
//        alert.addTextField { (alertTitleField) in
//            alertTitleField.placeholder = "Snag Name"
//            titleField = alertTitleField
//        }
//        alert.addTextField { (alertDetailField) in
//            alertDetailField.placeholder = "Snag Details (Optional)"
//            detailField = alertDetailField
//        }
//
//        //Define Cancel and Add Actions
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
//
//            //Create blank Snag
//            let newSnag = Snag()
//
//            //Assign Data to new Snag
//            newSnag.title = titleField.text!
//            newSnag.detail = detailField.text ?? ""
//            newSnag.dateCreated = Date()
//
//            //Save New Snag into Realm Database
//            self.saveData(fromNewSnag: newSnag)
//        }
//
//        //Add Actions to the Alert
//        alert.addAction(cancelAction)
//        alert.addAction(addAction)
//
//        //Present Alert Controller
//        present(alert, animated: true, completion: nil)
//
//    }
    
}
}
