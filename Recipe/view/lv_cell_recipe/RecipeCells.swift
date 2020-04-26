//
//  RecipeCells.swift
//  Recipe
//
//  Created by Ali on 25/04/2020.
//  Copyright © 2020 meor. All rights reserved.
//

import UIKit

class RecipeCells: UICollectionViewCell {

    @IBOutlet var backGround: UIView!
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var recipeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureRecipe(recipeItems : RecipeItems){
        backGround.layer.cornerRadius = 10
        recipeImage.layer.cornerRadius = 10
        recipeName.layer.cornerRadius = 10
        recipeName.text = recipeItems.name
        recipeImage.image = UIImage(data: recipeItems.image! as Data)
    }

}
