//
//  ViewController.swift
//  Snag1
//
//  Created by Eugene Trumpelmann on 2018/10/30.
//  Copyright © 2018 Eugene Trumpelmann. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup TableView parameters
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
    }


    //MARK: - Setup Basic Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self

        return cell

    }
    
    //MARK: - Setup Edit Actions
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else {return nil}
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            //Handle Action by calling overridable function
            self.updateModel(at: indexPath)
        }
        
        //Add Trash icon
        deleteAction.image = UIImage(named: "trash-icon")
        return [deleteAction]
    }
    
    //MARK: - Set Edit options
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
        
    }
    
    //MARK: - Data manipulation (Realm methods)
    
    func updateModel(at indexpath: IndexPath){
        
        //Model Present for override functionality in subclasses
    }
}

