//
//  FoodItemCollectionViewCell.swift
//  CollectionViewFullProgram
//
//  Created by Sanjana pethani on 04/01/23.
//

import UIKit

class FoodItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

}
