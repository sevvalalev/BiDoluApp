//
//  FoodsInteractor.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 12.02.2023.
//

import Foundation
import Alamofire

class FoodsInteractor: PresenterToInteractorFoodsProtocol {
    
    var presenter: InteractorToPresenterFoodsProtocol?
    
    
    func loadFoods() {
        AF.request(C.URL.allFoods, method: .get, parameters: nil, headers: nil, interceptor: nil).response { response in
            guard let data = response.data else {return}
            do {
                let response = try JSONDecoder().decode(FoodsAnswer.self, from: data)
                if let list = response.foods{
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.sendDataToPresenter(foodList: list)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}


