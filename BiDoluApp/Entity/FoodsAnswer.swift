//
//  FoodsAnswer.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 13.02.2023.
//

import Foundation

class FoodsAnswer: Codable {
    var foods:[Foods]?
    var success:Int?
    
    enum CodingKeys: String, CodingKey {
        case foods = "yemekler"
        case success = "success"
    }
}
