//
//  DetailRouter.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 12.02.2023.
//

import Foundation

class DetailRouter : PresenterToRouterFoodDetailProtocol {
    static func createModule(ref:DetailVC) {
        ref.presenter = DetailPresenter()
        ref.presenter?.interactor = DetailInteractor()
        
        let presenter = DetailPresenter()
        
        ref.presenter = presenter
        
        ref.presenter?.interactor = DetailInteractor()
        ref.presenter?.detailView = ref
        
        ref.presenter?.interactor?.presenter = presenter
    }
}
