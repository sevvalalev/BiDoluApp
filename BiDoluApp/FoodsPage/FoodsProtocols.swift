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
}

protocol PresenterToInteractorFoodsProtocol {
    var presenter: InteractorToPresenterFoodsProtocol? {get set}
    
    func loadFoods()
}

//Taşıyıcı Protocoller
protocol InteractorToPresenterFoodsProtocol {
    func sendDataToPresenter(foodList:[Foods])
}

protocol PresenterToViewFoodsProtocol {
    func sendDataToView()
    func animateLottie(filename: String)
    func navigateToDetailVC(food: Foods)
}

//Router Protocol
protocol PresenterToRouterFoodsProtocol {
    static func createModule(ref:FoodsVC)
}
