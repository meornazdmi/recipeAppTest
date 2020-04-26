//
//  DBManager.swift
//  Recipe
//
//  Created by meor on 24/04/2020.
//  Copyright © 2020 meor. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    private var   realm:Realm
    static let   sharedInstance = DBManager()
    private init() {
        
        realm = try! Realm()
    }
    
    func addRecipetoRealm(recipeItems : RecipeItems){
        try! realm.write {
            recipeItems.id = getTimeStamp()
            realm.add(recipeItems, update: .modified)
        }
    }
    
    func updateRecipe(recipeItems : RecipeItems, name : String ,ingredients : String , steps : String, image : NSData) {
        try! realm.write {
            recipeItems.name = name
            recipeItems.ingredients = ingredients
            recipeItems.step = steps
            recipeItems.image = image
            realm.add(recipeItems,update: .modified)
        }
    }
    
    func deleteRecipe(recipeItems : RecipeItems){
        try! realm.write {
            let item = realm.object(ofType: RecipeItems.self, forPrimaryKey: recipeItems.id!)
            realm.delete(item!)
            
        }
    }
    func getRealmRecipe() -> Results<RecipeItems> {
        return realm.objects(RecipeItems.self).sorted(byKeyPath: "name", ascending: true)
    }
    
    func filterRecipe(query : String) -> Results<RecipeItems> {
        if query.count > 0{
            let predicate = NSPredicate(format: "name CONTAINS[c] %@",query)
            return realm.objects(RecipeItems.self).filter(predicate)
        }
        else{
            return getRealmRecipe()
        }
    }
    
    func getTimeStamp() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = formatter.string(from: date)
        
        return result
    }
}
