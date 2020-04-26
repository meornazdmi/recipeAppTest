//
//  RecipeItems.swift
//  Recipe
//
//  Created by Ali on 25/04/2020.
//  Copyright © 2020 meor. All rights reserved.
//

import Foundation
import RealmSwift

class RecipeItems: Object {
    
    @objc dynamic var
    id,
    name,
    step,
    ingredients : String?
    
    @objc dynamic var image : NSData?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
