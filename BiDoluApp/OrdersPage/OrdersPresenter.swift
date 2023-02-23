//
//  OrdersPresenter.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 12.02.2023.
//

import Foundation

class OrdersPresenter: ViewToPresenterFoodOrdersProtocol {
    var interactor: PresenterToInteractorFoodOrdersProtocol?
    var view: PresenterToViewFoodOrdersProtocol?
    
    func giveOrder() {
        
    }
    
    func loadOrders(kullanici_adi: String) {
        interactor?.loadOrders(kullanici_adi: kullanici_adi)
    }
    
    func deleteOrder(sepet_yemek_id: String, kullanici_adi: String) {
        interactor?.deleteOrder(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
}

extension OrdersPresenter: InteractorToPresenterFoodOrdersProtocol {
    func sendOrdersToPresenter(foodList: [FoodOrders]) {
        view?.sendOrdersToView(foodList: foodList)
    }
}
