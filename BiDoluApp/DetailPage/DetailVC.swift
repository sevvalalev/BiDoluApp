//
//  DetailVC.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 11.02.2023.
//

import UIKit
import Kingfisher
import FirebaseAuth

class DetailVC: UIViewController {

    @IBOutlet private var detailView: UIView!
    @IBOutlet private var detailsView: UIView!
    @IBOutlet private var foodImage: UIImageView!
    @IBOutlet private var discountButton: UIButton!
    @IBOutlet private var popularButton: UIButton!
    @IBOutlet private var foodNameLabel: UILabel!
    @IBOutlet private var totalLabel: UILabel!
    @IBOutlet private var stepperLabel: UILabel!
    @IBOutlet private var stepper: UIStepper!
    @IBOutlet private var addCardButton: UIButton!
    @IBOutlet weak var stableLabel: UILabel!
    
    var foodList:Foods?
    var foodOrders: FoodOrders?
    var foodImageName:String?
    var presenter: ViewToPresenterFoodDetailProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepperLabel.text = String(Int(stepper.value))
        
        navigationController?.navigationBar.isHidden = false
        DetailRouter.createModule(ref: self)
        
        if let food = foodList { 
            foodImageName = "\(C.URL.pictures)\(food.yemek_resim_adi!)"
            foodNameLabel.text = food.yemek_adi
            totalLabel.text = food.yemek_fiyat!
            foodImage.kf.indicatorType = .activity
            foodImage.kf.setImage(with: URL(string: "\(C.URL.pictures)\(food.yemek_resim_adi!)"), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        }
        configureUI()
    }


    private func configureUI() {
        
        addCardButton.layer.cornerRadius = 15
        
        detailView.layer.cornerRadius = 40
        detailsView.layer.cornerRadius = 60
        
        discountButton.layer.cornerRadius = 20
        discountButton.layer.borderColor = UIColor.orange.cgColor
        discountButton.layer.borderWidth = 1
        
        popularButton.layer.cornerRadius = 20
        popularButton.layer.borderColor = UIColor.orange.cgColor
        popularButton.layer.borderWidth = 1
        
        detailsView.layer.cornerRadius = 20
        detailsView.layer.borderColor = UIColor.orange.cgColor
        detailsView.layer.borderWidth = 2
        detailView.layer.borderColor = UIColor.orange.cgColor
        detailView.layer.borderWidth = 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.Navigations.toOrder {
            if let food = sender as? FoodOrders {
                let dest = segue.destination as! OrdersVC
                dest.foodOrders = food
            }
        }
    }
    
    @IBAction private func addCardTapped(_ sender: UIButton) {
        guard let foodName = foodNameLabel.text,
              let foodImageName = foodImageName,
              let foodPrice = totalLabel.text,
              let totalOrder = stepperLabel.text,
              let username = C.User.username else { return }
        presenter?.addCard(yemek_adi: foodName, yemek_resim_adi: foodImageName, yemek_fiyat: Int(foodPrice)!, yemek_siparis_adet: Int(totalOrder)!, kullanici_adi: username)
    }
    
    @IBAction private func stepperControl(_ sender: UIStepper) {
        stepperLabel.text = String(Int(sender.value))
    }
    
}

extension DetailVC: PresenterToViewDetailProtocol {
    func navigateToOrdersVC() {
        performSegue(withIdentifier: C.Navigations.toOrder, sender: nil)
    }
}
