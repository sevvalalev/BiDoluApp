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
    
    var detailView:PresenterToViewDetailProtocol? {get set}
}


protocol PresenterToInteractorFoodDetailProtocol {
    var presenter: InteractorToPresenterDetailProtocol? {get set}
    func addCard(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}

protocol InteractorToPresenterDetailProtocol {
    func foodAddedToCard()
}

protocol PresenterToViewDetailProtocol {
    func navigateToOrdersVC()
}

protocol PresenterToRouterFoodDetailProtocol {
    static func createModule(ref:DetailVC)
}
