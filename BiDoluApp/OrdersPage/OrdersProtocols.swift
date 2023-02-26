//
//  OrdersProtocols.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 12.02.2023.
//

import Foundation

protocol ViewToPresenterFoodOrdersProtocol {
    var interactor:PresenterToInteractorFoodOrdersProtocol? {get set}
    var view:PresenterToViewFoodOrdersProtocol? {get set}
    
    func loadOrders(kullanici_adi:String)
    func deleteOrder(sepet_yemek_id:String,kullanici_adi:String)
    func deleteCard()
    func orderButtonTapped()
}

protocol PresenterToInteractorFoodOrdersProtocol {
    var presenter: InteractorToPresenterFoodOrdersProtocol? {get set}
    
    func loadOrders(kullanici_adi:String)
    func deleteOrder(sepet_yemek_id:String,kullanici_adi:String)
}

protocol InteractorToPresenterFoodOrdersProtocol {
    func sendOrdersToPresenter(foodList: [FoodOrders])
    func deleteOrderCompleted()
}

protocol PresenterToViewFoodOrdersProtocol {
    func sendOrdersToView(foodList: [FoodOrders], totalPrice: Int)
    func playLottie(lottieFile: String)
    func hideHUD()
}

protocol PresenterToRouterFoodOrdersProtocol {
    static func createModule(ref:OrdersVC)
}
