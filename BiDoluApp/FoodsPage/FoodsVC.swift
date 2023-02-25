//
//  FoodsVC.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 8.02.2023.
//

import UIKit
import Lottie
import ProgressHUD

class FoodsVC: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var sortingButton: UIButton!
    
    
    private let spacing:CGFloat = 10
    
    var presenter:ViewToPresenterFoodsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        customNib()
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
        let customCellNib: UINib = UINib(nibName: C.Identifier.CollectionView, bundle: nil)
        collectionView.register(customCellNib, forCellWithReuseIdentifier: C.Identifier.CollectionView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.Navigations.toDetail {
            if let food = sender as? Foods {
                let dest = segue.destination as! DetailVC
                dest.foodList = food
            }
        }
    }
    
    @IBAction private func randomFoodButtonTapped(_ sender: UIButton) {
        presenter?.randomFoodTapped()
    }
    
    
    @IBAction private func sortingTapped(_ sender: UIButton) {
        presenter?.sortFoodPrice()
    }
}


extension FoodsVC : PresenterToViewFoodsProtocol {
    func sendDataToView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func animateLottie(filename: String) {
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.bringSubviewToFront(containerView)
        let animationView = AnimationView(name: filename)
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.5
        containerView.addSubview(animationView)
        animationView.play {[weak self] _ in
            containerView.removeFromSuperview()
            self?.presenter?.lottieCompleted()
        }
    }
    
    func navigateToDetailVC(food: Foods) {
        performSegue(withIdentifier: C.Navigations.toDetail, sender: food)
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.Identifier.CollectionView, for: indexPath) as? CollectionViewCell {
            let model = presenter?.getFood(for: indexPath)
            cell.configureUI(with: model)
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = presenter?.getFood(for: indexPath)
        guard let food = food else { return }
        navigateToDetailVC(food: food)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension FoodsVC: SelectedFoodProtocol {
    func addSelectedFood(with food: Foods?) {
        guard let food = food else { return }
        ProgressHUD.show("Ekleniyor")
        presenter?.addFoodToCard(food: food)
    }
    
    func hideHUD() {
        ProgressHUD.dismiss()
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
