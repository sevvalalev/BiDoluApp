//
//  OrdersTableViewCell.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 19.02.2023.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet private var foodView: UIView!
    @IBOutlet private var foodImage: UIImageView!
    @IBOutlet private var foodName: UILabel!
    @IBOutlet private var stepperLabel: UILabel!
    @IBOutlet private var totalLabel: UILabel!
    @IBOutlet private var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stepperLabel.text = String(Int(stepper.value))
        configureUI()
    }

    private func configureUI() {
        foodView.layer.cornerRadius = 20
        foodView.layer.borderColor = UIColor.orange.cgColor
        foodView.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        foodView.layer.borderWidth = 2
    }
    
    func configureUI(with food: FoodOrders) {
       /* var foodTotal: Int? = Int(totalLabel.text!)
        var piece: Int? = Int(stepperLabel.text!)
        var result = foodTotal * piece */
        
        foodName.text = food.yemek_adi!
        totalLabel.text = "\(food.yemek_fiyat) ₺"
        stepperLabel.text = "\(food.yemek_siparis_adet!)"
        foodImage.kf.indicatorType = .activity
        foodImage.kf.setImage(with:URL(string: "\(food.yemek_resim_adi!)"), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func stepperControl(_ sender: UIStepper) {
        stepperLabel.text = String(Int(sender.value))
    }
}
