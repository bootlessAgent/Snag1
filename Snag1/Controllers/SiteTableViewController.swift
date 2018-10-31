//
//  SiteTableViewController.swift
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

class SiteTableViewController: SwipeTableViewController {

    //MARK: - Class Initializers
    let realm = try! Realm()
    var sites : Results<Site>?
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
        
        sites = realm.objects(Site.self)
        tableView.reloadData()
        
    }
    
    //Create and Update Data
    func saveData(fromNewSite site: Site){
        
        do{
            try realm.write {
                realm.add(site)
            }
            
        }catch{
            print("Error saving data with: \(error)")
        }
        tableView.reloadData()
    }
    
    //Delete Data
    override func updateModel(at indexpath: IndexPath) {
        
        if let siteForDeletion = self.sites?[indexpath.row] {
            
            do{
                try self.realm.write {
                    self.realm.delete(siteForDeletion)
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
        
        if let site = sites?[indexPath.row]{
            cell.textLabel?.text = site.title
            cell.detailTextLabel?.text = site.detail
        }else{
            cell.textLabel?.text = "Add a new Site..."
        }
        return cell
    }
    
    //TableView Bounds setup
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sites?.count ?? 1
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
        let alert = UIAlertController(title: "Add New Site", message: "", preferredStyle: .alert)
        
        //Add Title & Detail fields To Alert
        alert.addTextField { (alertTitleField) in
            alertTitleField.placeholder = "Site Name"
            titleField = alertTitleField
        }
        alert.addTextField { (alertDetailField) in
            alertDetailField.placeholder = "Site Details (Optional)"
            detailField = alertDetailField
        }
        
        //Define Cancel and Add Actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //Create blank Site
            let newSite = Site()
            
            //Assign Data to new Site
            newSite.title = titleField.text!
            newSite.detail = detailField.text ?? ""
            newSite.dateCreated = Date()
            
            //Save New Site into Realm Database
            self.saveData(fromNewSite: newSite)
        }
    
        //Add Actions to the Alert
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        //Present Alert Controller
        present(alert, animated: true, completion: nil)
        
    }
    
}
