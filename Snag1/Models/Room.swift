//
//  Room.swift
//  Snag1
//
//  Created by Eugene Trumpelmann on 2018/10/31.
//  Copyright © 2018 Eugene Trumpelmann. All rights reserved.
//

import Foundation
import RealmSwift

class Room: ModelTemplate {
    
    let parentBuilding = LinkingObjects(fromType: Building.self, property: "rooms")
    let snags = List<Snag>()
}
