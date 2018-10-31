//
//  Building.swift
//  Snag1
//
//  Created by Eugene Trumpelmann on 2018/10/31.
//  Copyright © 2018 Eugene Trumpelmann. All rights reserved.
//

import Foundation
import RealmSwift

class Building: ModelTemplate {
    
    let parentSite = LinkingObjects(fromType: Site.self, property: "buildings")
    let rooms = List<Room>()
    
}
