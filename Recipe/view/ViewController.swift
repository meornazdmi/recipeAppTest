//
//  ViewController.swift
//  Recipe
//
//  Created by Ali on 24/04/2020.
//  Copyright © 2020 meor. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController , IRecipeModel{
    
    @IBOutlet var recyclerViewRecipe: UICollectionView!
    @IBOutlet var searchTxt: UITextField!
    
    let dbManager = DBManager.sharedInstance
    var result = DBManager.sharedInstance.getRealmRecipe()
    var delegate : IRecipeModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recyclerViewRecipe.backgroundColor = UIColor.clear
        self.recyclerViewRecipe.register(UINib.init(nibName: "RecipeCells", bundle: nil), forCellWithReuseIdentifier: "RecipeCells")
        
        if result.count == 0{
            addRecipe()
        }
    }
    @IBAction func searchRecipe(_ sender: Any) {
        result = dbManager.filterRecipe(query: searchTxt.text!)
        reloadColectionViewRecipe()
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        switch (sender as AnyObject).tag {
        case 0://more btn
            print("xx more btn")
        default://to fragment
            print("xx add btn")
            let vc = NewRecipeFragment()
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.default
        nav?.tintColor = UIColor.yellow
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
          
        let image = UIImage(named: "recipe")
        imageView.image = image
          
        navigationItem.titleView = imageView
    }
    
    func reloadColectionViewRecipe(){
        recyclerViewRecipe.reloadData()
        recyclerViewRecipe!.collectionViewLayout.invalidateLayout()
        recyclerViewRecipe.layoutSubviews()
    }

}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = Int(indexPath.row)
        let recipe = result[index]
        let vc = RecipeDetailsFragment()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        vc.recipeItems = recipe
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCells", for: indexPath) as! RecipeCells
            let index = indexPath.row
            let item = self.result[index]
            cell.configureRecipe(recipeItems: item)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow = 2
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
   
        return CGSize(width: size, height: size/2)
    }
    
    func refreshdata(status: Bool) {
        if status{
            recyclerViewRecipe.reloadData()
        }
    }
    
    func addRecipe(){
    
        let recipeItem : RecipeItems = RecipeItems()
        recipeItem.image = NSData(data: UIImage(named: "ayam")!.jpegData(compressionQuality: 0.9)!)
        recipeItem.name = "Ayam Masak Merah"
        recipeItem.ingredients = """
        1.1/2 ekor ayam
        2.sedikit garam kunyit
        3.## Bahan-bahan kisar ##
        4.4-5 biji cili kering
        5.1 cm halia
        6.2 ulas bawang putih
        7.1 labu bawang besar
        8.1 biji tomato-potong dadu
        9.1/2 cawan sos tomato
        .## Bahan Hias ##
        10.1/2 biji bawang besar- potong bulat
        11.kacang hijau secukupnya
        """
        recipeItem.step = """
        1.Bersih ayam. Potong kecil-kecil dan gaul dengan garam kunyit. Goreng sehingga 2/3 masak
        2.Tumis bahan kisar kecuali sos tomato dan tomato sehingga naik bau. Kemudian barulah dimasukkan sos dan buah tomato. Tumis sehingga naik minyak.
        3.Masukkan ayam. Biar kuah jadi pekat. Sekali sekala hendaklah digaul balikkan.
        4.Bila kuah dah pekat bolehlah masuk bahan-bahan hias. Biar 1-2 minit. Kemudian padamkan api.
        """
        dbManager.addRecipetoRealm(recipeItems: recipeItem)
    }
}
