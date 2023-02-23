//
//  SecondCollectionViewCell.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 11.02.2023.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {

    @IBOutlet var orderView: UIView!
    static let identifier = "secondCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        orderView.layer.cornerRadius = 20
    }

}
