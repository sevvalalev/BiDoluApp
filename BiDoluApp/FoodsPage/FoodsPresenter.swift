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
    private var isSortActive: Bool = false
    
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
    
    func sortFoodPrice() {
        isSortActive.toggle()
        
        if isSortActive {
            foodList = foodList.sorted(by: { Int($0.yemek_fiyat ?? "0") ?? 0 < Int($1.yemek_fiyat ?? "0") ?? 0 })
            foodsView?.sendDataToView()
        } else {
            loadFoods()
        }
    }
    
    func randomFoodTapped() {
        foodsView?.animateLottie(filename: C.LottieFiles.foodWheel)
    }
    
    func lottieCompleted() {
        let randomFood = foodList.randomElement() ?? foodList[0]
        foodsView?.navigateToDetailVC(food: randomFood)
    }
    
    func addFoodToCard(food: Foods) {
        interactor?.addCard(yemek_adi: food.yemek_adi ?? "",
                            yemek_resim_adi: "\(C.URL.pictures)\(food.yemek_resim_adi ?? "")",
                            yemek_fiyat: Int(food.yemek_fiyat ?? "0") ?? 0,
                            yemek_siparis_adet: 1,
                            kullanici_adi: C.User.username ?? "")
    }
}

extension FoodsPresenter : InteractorToPresenterFoodsProtocol {
    func sendDataToPresenter(foodList: [Foods]){
        self.foodList = foodList
        foodsView?.sendDataToView()
    }
    
    func addCardCompleted() {
        foodsView?.hideHUD()
    }
}
