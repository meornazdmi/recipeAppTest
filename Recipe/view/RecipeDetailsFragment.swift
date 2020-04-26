//
//  RecipeDetailsFragment.swift
//  Recipe
//
//  Created by Ali on 26/04/2020.
//  Copyright © 2020 meor. All rights reserved.
//

import UIKit

class RecipeDetailsFragment: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var recipeImg: UIImageView!
    @IBOutlet var recipeName: UITextField!
    @IBOutlet var recipeIngredients: UITextView!
    @IBOutlet var recipeSteps: UITextView!
    @IBOutlet var updateBtn: UIButton!
    
    let dbManger = DBManager.sharedInstance
    let imagePicker = UIImagePickerController()
    var delegate : IRecipeModel!
    var recipeItems = RecipeItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        recipeSteps.text = recipeItems.step
        recipeIngredients.text = recipeItems.ingredients
        recipeName.text = recipeItems.name
        recipeImg.image = UIImage(data: recipeItems.image! as Data)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        recipeImg.isUserInteractionEnabled = true
        recipeImg.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        
        let imageData = NSData(data: recipeImg.image!.jpegData(compressionQuality: 0.9)!)
        dbManger.updateRecipe(recipeItems: recipeItems, name: recipeName.text!, ingredients: recipeIngredients.text!, steps: recipeSteps.text!, image: imageData)
            self.delegate.refreshdata(status: true)
            self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        dbManger.deleteRecipe(recipeItems: recipeItems)
        self.delegate.refreshdata(status: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    //image picker
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {        
        let alert = UIAlertController(title: nil, message: "Choose your source", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { (result : UIAlertAction) -> Void in
            print("xx Camera selected")
            self.opencamera()
        })
        alert.addAction(UIAlertAction(title: "Photo library", style: .default) { (result : UIAlertAction) -> Void in
            print("xx Photo selected")
            self.opengallery()
        })
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    //open camera
    func opencamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    //open gallery
    func opengallery(){
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    //pick image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.recipeImg.contentMode = .scaleAspectFit
            self.recipeImg.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //cancel pick image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
