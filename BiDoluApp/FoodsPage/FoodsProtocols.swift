//
//  FoodsProtocols.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 12.02.2023.
//

import Foundation
//view presenter interactor

protocol ViewToPresenterFoodsProtocol {
    var interactor:PresenterToInteractorFoodsProtocol? {get set}
    var foodsView:PresenterToViewFoodsProtocol? {get set}
    
    func loadFoods()
    func search(searchWord:String)
    func getListCount() -> Int
    func getFood(for indexPath: IndexPath) -> Foods
    func randomFoodTapped()
    func lottieCompleted()
    func addFoodToCard(food: Foods)
}

protocol PresenterToInteractorFoodsProtocol {
    var presenter: InteractorToPresenterFoodsProtocol? {get set}
    
    func loadFoods()
    func addCard(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String)
}

//Taşıyıcı Protocoller
protocol InteractorToPresenterFoodsProtocol {
    func sendDataToPresenter(foodList:[Foods])
    func addCardCompleted()
}

protocol PresenterToViewFoodsProtocol {
    func sendDataToView()
    func animateLottie(filename: String)
    func navigateToDetailVC(food: Foods)
    func hideHUD()
}

//Router Protocol
protocol PresenterToRouterFoodsProtocol {
    static func createModule(ref:FoodsVC)
}
