//
//  OrdersRouter.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 12.02.2023.
//

import Foundation

class OrdersRouter : PresenterToRouterFoodOrdersProtocol {
    static func createModule(ref: OrdersVC) {
        let presenter = OrdersPresenter()
        
        ref.presenter = presenter
        
        ref.presenter?.interactor = OrdersInteractor()
        ref.presenter?.view = ref
        ref.presenter?.interactor?.presenter = presenter
    }
    
    
}
