//
//  BuildingTableViewController.swift
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

import UIKit
import RealmSwift

class BuildingTableViewController: SwipeTableViewController {
    
    //MARK: - Class Initializers
    let realm = try! Realm()
    var buildings : Results<Building>?
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
        
        buildings = realm.objects(Building.self)
        tableView.reloadData()
        
    }
    
    //Create and Update Data
    func saveData(fromNewBuilding building: Building){
        
        do{
            try realm.write {
                realm.add(building)
            }
            
        }catch{
            print("Error saving data with: \(error)")
        }
        tableView.reloadData()
    }
    
    //Delete Data
    override func updateModel(at indexpath: IndexPath) {
        
        if let buildingForDeletion = self.buildings?[indexpath.row] {
            
            do{
                try self.realm.write {
                    self.realm.delete(buildingForDeletion)
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
        
        if let buildings = buildings?[indexPath.row]{
            cell.textLabel?.text = buildings.title
            cell.detailTextLabel?.text = buildings.detail
        }else{
            cell.textLabel?.text = "Add a new Building..."
        }
        return cell
    }
    
    //TableView Bounds setup
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings?.count ?? 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    ////////////////////////////
    
    
    //MARK: - Button Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //Define Superscope textfields for alert fields
        var titleField = UITextField()
        var detailField = UITextField()
        
        //Define Alert Controller and options
        let alert = UIAlertController(title: "Add New Building", message: "", preferredStyle: .alert)
        
        //Add Title & Detail fields To Alert
        alert.addTextField { (alertTitleField) in
            alertTitleField.placeholder = "Building Name"
            titleField = alertTitleField
        }
        alert.addTextField { (alertDetailField) in
            alertDetailField.placeholder = "Building Details (Optional)"
            detailField = alertDetailField
        }
        
        //Define Cancel and Add Actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //Create blank Building
            let newBuilding = Building()
            
            //Assign Data to new Building
            newBuilding.title = titleField.text!
            newBuilding.detail = detailField.text ?? ""
            newBuilding.dateCreated = Date()
            
            //Save New Building into Realm Database
            self.saveData(fromNewBuilding: newBuilding)
        }
        
        //Add Actions to the Alert
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        //Present Alert Controller
        present(alert, animated: true, completion: nil)
        
    }
}

