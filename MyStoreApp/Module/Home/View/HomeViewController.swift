//
//  HomeViewController.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import UIKit


class HomeViewController: BaseViewController {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    var presenter: HomePresenterProtocol?

    required init(homePresenter: HomePresenterProtocol) {
        super.init(
            nibName: HomeViewController.typeName,
            bundle: Bundle(for: type(of: self))
        )
        self.presenter = homePresenter
        
        presenter?.getProductsList()
        print("HomeViewController initialized")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Demo Store"
        print("viewDidLoad called")
        
        productsCollectionView?.dataSource = self
        productsCollectionView?.delegate = self
        
        productsCollectionView?.isPrefetchingEnabled = true

        
        let productNibCell = UINib(nibName: ProductCellView.nibName, bundle: nil)
        productsCollectionView?.register(productNibCell, forCellWithReuseIdentifier: ProductCellView.reuseIdentifier)
        
        categoriesCollectionView?.dataSource = self
        categoriesCollectionView?.delegate = self
        
        categoriesCollectionView?.isPrefetchingEnabled = true

        
        let categoryNibCell = UINib(nibName: CategoryCellView.nibName, bundle: nil)
        categoriesCollectionView?.register(categoryNibCell, forCellWithReuseIdentifier: CategoryCellView.reuseIdentifier)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
    }

}

extension HomeViewController: HomeViewProtocol {
    func updateView() {
        productsCollectionView?.reloadData()
        categoriesCollectionView?.reloadData()
    }
    
    func updateProductList(){
        productsCollectionView?.reloadData()
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    //Devuelve el tamaño de un elemento específico en la colección.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == productsCollectionView){
            return CGSize(width: 160, height: 200)
        }else{
            
            return CGSize(width: 140, height: 40)
        }
        
    }
    //Define el espacio vertical entre las filas de la sección.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    //Define el espacio horizontal entre elementos de la misma fila.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    //Establece márgenes alrededor de los elementos en una sección.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }



}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == productsCollectionView){
            return presenter?.getProductsListSize() ?? 0
        }else{
            return presenter?.getCategoriesListSize() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == productsCollectionView){
            if let productCell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCellView.reuseIdentifier, for: indexPath) as? ProductCellView {
                guard let product = presenter?.getProduct(index: indexPath.row) else{ return productCell }
                productCell.configureCell(product: product)
                
                return productCell
            }else{
                return UICollectionViewCell()
            }
        }else{
            
            if let productCell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCellView.reuseIdentifier, for: indexPath) as? CategoryCellView {
                guard let category = presenter?.getCategory(index: indexPath.row) else{ return productCell }
                productCell.configureCell(cateoryName: category)
                
                return productCell
            }else{
                return UICollectionViewCell()
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Celda seleccionada en la sección \(indexPath.section), fila \(indexPath.row)")

        if (collectionView == productsCollectionView){
            presenter?.showSingleProduct(index: indexPath.row)
        }else{
            presenter?.getProductsByCategory(index:indexPath.row)
        }
    }

    
    
}
