//
//  OrdersInteractor.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 12.02.2023.
//

import Foundation
import Alamofire

class OrdersInteractor: PresenterToInteractorFoodOrdersProtocol {
    
    var presenter: InteractorToPresenterFoodOrdersProtocol?
    
    func loadOrders(kullanici_adi: String) {
        let parameter = ["kullanici_adi":kullanici_adi]
        AF.request(C.URL.loadOrders,method: .post,parameters: parameter).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(FoodOrdersAnswer.self, from: data)
                    if let list = response.sepet_yemekler {
                        self.presenter?.sendOrdersToPresenter(foodList: list)
                    }
                    print("Yemekler sepete başarı ile çekildi.")
                } catch {
                    self.presenter?.sendOrdersToPresenter(foodList: [])
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteOrder(sepet_yemek_id: String, kullanici_adi: String) {
        let parameter = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi] as [String:Any]
        AF.request(C.URL.deleteOrder,method: .post,parameters: parameter).response {response in
            print("dispatchhhh completed \(sepet_yemek_id)")
            self.presenter?.deleteOrderCompleted()
            if let data = response.data {
                do{
                    let response = try JSONDecoder().decode(FoodOrdersAnswer.self, from: data)
                    print("Sipariş silindi.")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
