//
//  FoodsPresenter.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 12.02.2023.
//

import Foundation

class FoodsPresenter : ViewToPresenterFoodsProtocol {
    
    var interactor: PresenterToInteractorFoodsProtocol?
    var foodsView: PresenterToViewFoodsProtocol?
    
    private var foodList: [Foods] = []
    private var searchedItems: [Foods] = []
    private var searchedWord: String = ""
    
    func loadFoods() {
        interactor?.loadFoods()
    }
    
    func search(searchWord: String) {
        searchedWord = searchWord
        searchedItems = foodList.filter({$0.yemek_adi?.lowercased().contains(searchWord.lowercased()) ?? false })
        foodsView?.sendDataToView()
    }
    
    func getListCount() -> Int {
        return activeArray().count
    }
    
    func getFood(for indexPath: IndexPath) -> Foods {
        return activeArray()[indexPath.row]
    }
    
    private func activeArray() -> [Foods] {
        if searchedWord.count == 0 {
            return foodList
        } else {
            return searchedItems
        }
    }
    
    func randomFoodTapped() {
        foodsView?.animateLottie(filename: C.LottieFiles.foodWheel)
    }
    
    func lottieCompleted() {
        let randomFood = foodList.randomElement() ?? foodList[0]
        foodsView?.navigateToDetailVC(food: randomFood)
    }
}

extension FoodsPresenter : InteractorToPresenterFoodsProtocol {
    func sendDataToPresenter(foodList: [Foods]){
        self.foodList = foodList
        foodsView?.sendDataToView()
    }
}
