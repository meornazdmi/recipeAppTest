//
//  NewRecipeFragment.swift
//  Recipe
//
//  Created by Ali on 25/04/2020.
//  Copyright © 2020 meor. All rights reserved.
//

import UIKit

class NewRecipeFragment: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    
    @IBOutlet var recipeImg: UIImageView!
    @IBOutlet var recipeName: UITextField!
    @IBOutlet var recipeIngredients: UITextView!
    @IBOutlet var recipeSteps: UITextView!
    
    let dbManger = DBManager.sharedInstance
    let imagePicker = UIImagePickerController()
    var selectedImage :  UIImage? = nil
    var delegate : IRecipeModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        recipeIngredients.text = "Ingredients"
        recipeIngredients.textColor = UIColor.lightGray
        recipeSteps.text = "Steps"
        recipeSteps.textColor = UIColor.lightGray
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        recipeImg.isUserInteractionEnabled = true
        recipeImg.addGestureRecognizer(tapGestureRecognizer)
    }

    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        
        if recipeName.text!.isEmpty || recipeSteps.text! == "Steps" || recipeIngredients.text! == "Ingredients" || selectedImage == nil{
            print("xx error please fill in required field")
        }
        else{
            let recipeItem = RecipeItems()
            let imageData = NSData(data: selectedImage!.jpegData(compressionQuality: 0.9)!)
            recipeItem.image = imageData
            recipeItem.name = recipeName.text
            recipeItem.ingredients = recipeIngredients.text
            recipeItem.step = recipeSteps.text
            dbManger.addRecipetoRealm(recipeItems: recipeItem)
            self.delegate.refreshdata(status: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    

      //image picker
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("xx image add")

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
              self.selectedImage = pickedImage
          }
          
          dismiss(animated: true, completion: nil)
      }
    
      //cancel pick image
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          
          dismiss(animated: true, completion: nil)
          
      }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView == recipeIngredients{
                textView.text = "Ingredients"
            }
            else{
                textView.text = "Steps"
            }
            textView.textColor = UIColor.lightGray
        }
    }
}
