//
//  FoodsVC.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 8.02.2023.
//

import UIKit
import Kingfisher
import FirebaseAuth

class FoodsVC: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var sortingButton: UIButton!
    
    private let spacing:CGFloat = 10
    
    var presenter:ViewToPresenterFoodsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        customNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        configureLayout()
        FoodsRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        presenter?.loadFoods()
    }
    
    
    private func configureLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        
        collectionView.collectionViewLayout = layout
    }
    
    private func customNib() {
        let customCellNib: UINib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(customCellNib, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let food = sender as? Foods {
                let dest = segue.destination as! DetailVC
                dest.foodList = food
            }
        }
    }
    
    @IBAction private func sortingTapped(_ sender: UIButton) {
        
    }
}


extension FoodsVC : PresenterToViewFoodsProtocol {
    func sendDataToView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension FoodsVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.search(searchWord: searchText)
    }}

extension FoodsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getListCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell {
            let model = presenter?.getFood(for: indexPath)
            cell.configureUI(with: model)
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = presenter?.getFood(for: indexPath)
        performSegue(withIdentifier: "toDetailVC", sender: food)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension FoodsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 10
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            let height = (collectionView.bounds.width - totalSpacing)/1.7
            return CGSize(width: width, height: height)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
}
