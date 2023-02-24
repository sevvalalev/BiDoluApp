//
//  OrdersVC.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 11.02.2023.
//

import UIKit
import FirebaseAuth
import Kingfisher

class OrdersVC: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var orderButton: UIButton!
    @IBOutlet private var totalLabel: UILabel!
    
    var foodList = [FoodOrders]()
    var foodOrders: FoodOrders?
    var presenter: ViewToPresenterFoodOrdersProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureTableView()
        OrdersRouter.createModule(ref: self)
        orderButton.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let username = C.User.username else {return}
        presenter?.loadOrders(kullanici_adi: username)
    }
    
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let customCellNib: UINib = UINib(nibName: C.Identifier.tableViewCell, bundle: nil)
        tableView.register(customCellNib, forCellReuseIdentifier: C.Identifier.tableViewCell)
    }
    
    @IBAction private func deleteTapped(_ sender: UIBarButtonItem) {
       
    }
}

extension OrdersVC: PresenterToViewFoodOrdersProtocol {
    func sendOrdersToView(foodList: [FoodOrders]) {
        self.foodList = foodList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension OrdersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: C.Identifier.tableViewCell,for:indexPath) as? OrdersTableViewCell {
            cell.configureUI(with: foodList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Sil") { (UIContextualAction, view, bool) in
            let food = self.foodList[indexPath.row]
            let alert = UIAlertController(title: "Dikkat!", message: "\(food.yemek_adi!) silinsin mi ?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.presenter?.deleteOrder(sepet_yemek_id: food.sepet_yemek_id!, kullanici_adi: C.User.username!)
            }
            alert.addAction(okAction)
            tableView.reloadData()
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
