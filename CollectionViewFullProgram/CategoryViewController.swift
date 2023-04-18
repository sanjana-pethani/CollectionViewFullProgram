//
//  CategoryViewController.swift
//  CollectionViewFullProgram
//
//  Created by Sanjana pethani on 04/01/23.
//

struct FoodItem{
    var id: Int
    var name: String
    var price: Double
    var discountPrice: Double
    var quantity: Int = 0
}

struct MobileItem{
    var id: Int
    var name: String
    var price: Double
    var discountPrice: Double
    var releasedYear: String
}


import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var foodItemcollectionView: UICollectionView!
    var arrFoodItems: [FoodItem] = []
    var arrMobileItem: [MobileItem] = []
    var numberOfItemInRow: Int = 2
    var interItemSpace: CGFloat = 16
    
    var selectItemIndex: Int = -2

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
    }

    private func setup(){
        loadFoodItems()
        loadMobileItem()
     //   configureCatagoryCollection()
    }
    
    private func loadFoodItems(){
        let pitzza: FoodItem = FoodItem(id: 1, name: "Pitzza", price: 240, discountPrice: 50)
        let burgur: FoodItem = FoodItem(id: 2, name: "Burgur", price: 50, discountPrice: 10)
        let dosha: FoodItem = FoodItem(id: 3, name: "Dosha", price: 120, discountPrice: 20)
        let dabeli: FoodItem = FoodItem(id: 4, name: "Dabeli", price: 15, discountPrice: 5)
        let meggi: FoodItem = FoodItem(id: 5, name: "Meggi", price: 30, discountPrice: 5)
        let pasta: FoodItem = FoodItem(id: 6, name: "Pasta", price: 25, discountPrice: 7)
        
        arrFoodItems = [pitzza,burgur,dosha,dabeli,meggi,pasta]
        
    }
    private func loadMobileItem(){
        let iPhone14: MobileItem = MobileItem(id: 1, name: "IPhone 14", price: 56472, discountPrice: 2000, releasedYear: "2022")
        let oppoA77: MobileItem = MobileItem(id: 2, name: "Oppo A77", price: 16500, discountPrice: 2000, releasedYear: "2022")
        let vivoV25: MobileItem = MobileItem(id: 3, name: "Vivo V25", price: 14600, discountPrice: 1500, releasedYear: "2021")
        
        arrMobileItem = [iPhone14,oppoA77,vivoV25]
        
    }
    
    func configureCatagoryCollection(){
        let nibFile: UINib = UINib(nibName: "FoodItemCollectionViewCell", bundle: nil)
        foodItemcollectionView.register(nibFile, forCellWithReuseIdentifier: "FoodItemCollectionViewCell")
        
        
        foodItemcollectionView.register(UINib(nibName: "MobileItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MobileItemCollectionViewCell")
    }

}

extension CategoryViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return arrFoodItems.count
        } else {
            return arrMobileItem.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell:FoodItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItemCollectionViewCell", for: indexPath) as! FoodItemCollectionViewCell
            print("Index Path \(indexPath)")
            print("Index \(indexPath.row)")
            cell.addButton.tag = indexPath.row
            cell.minusButton.tag = indexPath.row
            cell.addButton.addTarget(self, action: #selector(addButtonclicked(_:)), for: .touchUpInside)
            cell.minusButton.addTarget(self, action: #selector(minusButtonclicked(_:)), for: .touchUpInside)
            let foodItem = arrFoodItems[indexPath.row]
            cell.nameLabel.text = "\(foodItem.name) \n Quantity: \(foodItem.quantity)"
            cell.layer.borderColor = indexPath.row == selectItemIndex ? UIColor.red.cgColor : UIColor.black.cgColor
            return cell
        
        } else {
            let cell: MobileItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MobileItemCollectionViewCell", for: indexPath) as! MobileItemCollectionViewCell
            cell.nameLabel.text = arrMobileItem[indexPath.row].name
            cell.priceLabel.text = "$\(arrMobileItem[indexPath.row].price)"
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            return cell
        }
    }
    
    @objc
    func addButtonclicked(_ sender: UIButton){
        print("Add Button Click")
        arrFoodItems[sender.tag].quantity = arrFoodItems[sender.tag].quantity + 1
        foodItemcollectionView.reloadData()
    }
    
    @objc
    func minusButtonclicked(_ sender: UIButton){
        print("Add Button Click")
        arrFoodItems[sender.tag].quantity = arrFoodItems[sender.tag].quantity - 1
        foodItemcollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let foodItem = arrFoodItems[indexPath.row]
            selectItemIndex = indexPath.row
//            print(foodItem.name)
//            print(foodItem.id)
            collectionView.reloadData()
           
        }
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            let spacing = CGFloat(numberOfItemInRow+1) * interItemSpace
            let avilableWidth = collectionView.frame.width - spacing
            let cellWidth = avilableWidth / CGFloat(numberOfItemInRow)
            return CGSize(width: cellWidth, height: cellWidth)
        }
        else
        {
            let spacing = CGFloat(numberOfItemInRow+1) * interItemSpace
            let avilableWidth = collectionView.frame.width - spacing
            let cellWidth = avilableWidth / CGFloat(numberOfItemInRow)
            return CGSize(width: cellWidth, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
