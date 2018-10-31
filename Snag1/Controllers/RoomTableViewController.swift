//
//  RoomTableViewController.swift
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

class RoomTableViewController: SwipeTableViewController {
    
    //MARK: - Class Initializers
    let realm = try! Realm()
    var rooms : Results<Room>?
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
        
        rooms = realm.objects(Room.self)
        tableView.reloadData()
        
    }
    
    //Create and Update Data
    func saveData(fromNewRoom room: Room){
        
        do{
            try realm.write {
                realm.add(room)
            }
            
        }catch{
            print("Error saving data with: \(error)")
        }
        tableView.reloadData()
    }
    
    //Delete Data
    override func updateModel(at indexpath: IndexPath) {
        
        if let roomForDeletion = self.rooms?[indexpath.row] {
            
            do{
                try self.realm.write {
                    self.realm.delete(roomForDeletion)
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
        
        if let rooms = rooms?[indexPath.row]{
            cell.textLabel?.text = rooms.title
            cell.detailTextLabel?.text = rooms.detail
        }else{
            cell.textLabel?.text = "Add a new Room..."
        }
        return cell
    }
    
    //TableView Bounds setup
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms?.count ?? 1
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
        let alert = UIAlertController(title: "Add New Room", message: "", preferredStyle: .alert)
        
        //Add Title & Detail fields To Alert
        alert.addTextField { (alertTitleField) in
            alertTitleField.placeholder = "Room Name"
            titleField = alertTitleField
        }
        alert.addTextField { (alertDetailField) in
            alertDetailField.placeholder = "Room Details (Optional)"
            detailField = alertDetailField
        }
        
        //Define Cancel and Add Actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //Create blank Room
            let newRoom = Room()
            
            //Assign Data to new Room
            newRoom.title = titleField.text!
            newRoom.detail = detailField.text ?? ""
            newRoom.dateCreated = Date()
            
            //Save New Room into Realm Database
            self.saveData(fromNewRoom: newRoom)
        }
        
        //Add Actions to the Alert
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        //Present Alert Controller
        present(alert, animated: true, completion: nil)
        
    }
    
}
