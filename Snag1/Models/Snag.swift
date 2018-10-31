//
//  Snag.swift
//  Snag1
//
//  Created by Eugene Trumpelmann on 2018/10/31.
//  Copyright © 2018 Eugene Trumpelmann. All rights reserved.
//

import Foundation
import RealmSwift

class Snag: ModelTemplate {
    
    @objc dynamic var imageURL : String?
    let parentRoom = LinkingObjects(fromType: Room.self, property: "snags")
    
}
