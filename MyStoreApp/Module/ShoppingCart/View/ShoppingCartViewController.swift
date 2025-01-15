//
//  ShoppinCartViewController.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 13/01/25.
//

import Foundation
import UIKit

class ShoppingCartViewController: BaseViewController{
    
    
    @IBOutlet weak var sizeShoppingCartLbl: UILabel!
    @IBOutlet weak var totalShoppingCartLbl: UILabel!
    @IBOutlet weak var shoppingCartCollection: UICollectionView!
    var presenter: ShoppingCartPresenterProtocol?
    
    required init(presenter: ShoppingCartPresenterProtocol) {
        super.init(nibName: ShoppingCartViewController.typeName, bundle: Bundle(for: type(of: self)))
        
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mi carrito"
        shoppingCartCollection?.dataSource = self
        shoppingCartCollection?.delegate = self
        
        shoppingCartCollection?.isPrefetchingEnabled = true

        
        let nibCell = UINib(nibName: ProductCartCellView.nibName, bundle: nil)
        shoppingCartCollection?.register(nibCell, forCellWithReuseIdentifier: ProductCartCellView.reuseIdentifier)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        presenter?.getShoppinCart()
    }

    
}

extension ShoppingCartViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getCartSize() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let productCell = shoppingCartCollection.dequeueReusableCell(withReuseIdentifier: ProductCartCellView.reuseIdentifier, for: indexPath) as? ProductCartCellView {
            guard let product = presenter?.getProduct(index: indexPath.row) else{ return productCell }
            productCell.configureCell(product: product, presenter: presenter)
            
            return productCell
        }else{
            return UICollectionViewCell()
        }
    }
    
    
    
}

extension ShoppingCartViewController: UICollectionViewDelegateFlowLayout{
    
    //Devuelve el tamaño de un elemento específico en la colección.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 180)
    }
//    //Define el espacio vertical entre las filas de la sección.
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 22
//    }
//    //Define el espacio horizontal entre elementos de la misma fila.
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
//    //Establece márgenes alrededor de los elementos en una sección.
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
//    }



}


extension ShoppingCartViewController: ShoppingCartViewProtocol{
    
    func loadListCart(){
        shoppingCartCollection.reloadData()
    }
    
    func updateData(size: Int, total: String){
        
        sizeShoppingCartLbl.text = "\(size)"
        totalShoppingCartLbl.text = "$ \(total)"
        
    }
}
