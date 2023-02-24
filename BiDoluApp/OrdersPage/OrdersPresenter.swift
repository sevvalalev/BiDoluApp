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
        let prices = foodList.compactMap({Int($0.yemek_fiyat ?? "0")})
        let total = prices.reduce(0, +)
        
        var editedList: [FoodOrders] = []
        
        foodList.enumerated().forEach { (index, food) in
            if editedList.contains(where: {$0.yemek_adi == food.yemek_adi}) {
                var existingFood = food
                let editedListFoodCount = Int(editedList.first(where: {$0.yemek_adi == food.yemek_adi})?.yemek_siparis_adet ?? "0") ?? 0
                let foodCount = Int(food.yemek_siparis_adet ?? "0") ?? 0
                let foodTotalItemCount = editedListFoodCount + foodCount
                
                let editedListIndex = editedList.firstIndex(where: { $0.yemek_adi == existingFood.yemek_adi })
                existingFood.yemek_siparis_adet = "\(foodTotalItemCount)"
                editedList[editedListIndex ?? 0] = existingFood
            } else {
                editedList.append(food)
            }
        }
        
        view?.sendOrdersToView(foodList: editedList, totalPrice: total)
    }
}
