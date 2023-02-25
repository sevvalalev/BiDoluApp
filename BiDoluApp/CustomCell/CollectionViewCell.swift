//
//  CollectionViewCell.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 8.02.2023.
//

import UIKit
import Kingfisher

protocol SelectedFoodProtocol {
    func addSelectedFood(with food: Foods?)
}

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private var foodNameLabel: UILabel!
    @IBOutlet private var foodImageView: UIImageView!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var addButton: UIButton!
    @IBOutlet private var foodView: UIView!
    
    var currentFood: Foods?
    
    var delegate: SelectedFoodProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        foodView.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        foodView.layer.borderColor = UIColor.orange.cgColor
        foodView.layer.borderWidth = 2
        foodView.layer.cornerRadius = 30
        foodView.clipsToBounds = true
        
        addButton.layer.cornerRadius = 15
    }
    
    func configureUI(with model: Foods?) {
        guard let model = model else { return }
        currentFood = model
        foodNameLabel.text = model.yemek_adi
        priceLabel.text = "\(model.yemek_fiyat!) ₺"
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: URL(string: "\(C.URL.pictures)\(model.yemek_resim_adi!)"), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
    }
    
    @IBAction private func addButtonTapped(_ sender: UIButton) {
        delegate?.addSelectedFood(with: currentFood)
    }
}
