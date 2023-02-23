//
//  FoodsRouter.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 12.02.2023.
//

import Foundation

class FoodsRouter: PresenterToRouterFoodsProtocol {
    static func createModule(ref: FoodsVC) {
        let presenter = FoodsPresenter()
        
            ref.presenter = presenter
        
            ref.presenter?.interactor = FoodsInteractor()
            ref.presenter?.foodsView = ref
        
            ref.presenter?.interactor?.presenter = presenter
        }
    }

