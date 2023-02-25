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
    
    func addCard(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        let parameter = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi] as [String:Any]
        
        AF.request(C.URL.addCard, method: .post,parameters: parameter).response { response in
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(FoodOrdersAnswer.self, from: data)
                    print("Sipariş sepete eklendi")
                }catch{
                    print(error.localizedDescription)
                }
//                self.presenter?.foodAddedToCard()
            }
        }
    }
}


