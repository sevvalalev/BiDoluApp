//
//  Constants.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 23.02.2023.
//

import Foundation
import FirebaseAuth

struct C {
    struct URL{
        static let allFoods = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
        static let addCard = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        static let loadOrders = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        static let deleteOrder = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        static let pictures =  "http://kasimadalan.pe.hu/yemekler/resimler/"
    }
    struct Navigations {
        static let toDetail = "toDetailVC"
        static let toOrder = "toOrdersVC"
        
    }
    struct Identifier {
        static let CollectionView = "CollectionViewCell"
        static let tableViewCell = "OrdersTableViewCell"
    }
    struct User {
        static let username = Auth.auth().currentUser?.email
    }
    struct LottieFiles {
        static let boxDelivery = "boxdelivery"
        static let yellowDelivery = "yellowdelivery"
        static let order = "order"
        static let foodWheel = "foodWheel"
    }
}
