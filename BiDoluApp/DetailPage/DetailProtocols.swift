//
//  DetailProtocols.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 12.02.2023.
//

import Foundation

protocol ViewToPresenterFoodDetailProtocol {
    var interactor:PresenterToInteractorFoodDetailProtocol? {get set}
    func addCard(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}


protocol PresenterToInteractorFoodDetailProtocol {
    func addCard(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}

protocol InteractorToPresenterDetailProtocol {
    func sendDetailToPresenter(foodList: [FoodOrders])
}

protocol PresenterToViewDetailProtocol {
    func sendDetailToView(foodList: [FoodOrders])
}

protocol PresenterToRouterFoodDetailProtocol {
    static func createModule(ref:DetailVC)
}
