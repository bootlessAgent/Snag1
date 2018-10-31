//
//  ModelTemplate.swift
//  Snag1
//
//  Created by Eugene Trumpelmann on 2018/10/31.
//  Copyright © 2018 Eugene Trumpelmann. All rights reserved.
//

import Foundation
import RealmSwift

class ModelTemplate: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var detail : String = ""
    @objc dynamic var dateCreated : Date = Date()
    
    
}
