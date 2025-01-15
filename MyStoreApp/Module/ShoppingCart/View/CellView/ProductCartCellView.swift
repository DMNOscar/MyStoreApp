//
//  ProductCartCellView.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 13/01/25.
//

import UIKit
import Cosmos

class ProductCartCellView: UICollectionViewCell{
    
    @IBOutlet weak var nameProductLbl: UILabel!
    @IBOutlet weak var categoriaProductLbl: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var ratingProduct: CosmosView!
    @IBOutlet weak var priceProductLbl: UILabel!
    @IBOutlet weak var amountProductTFl: UITextField!
    
    var presenter: ShoppingCartPresenterProtocol?
    var product: Product?
    
    class var reuseIdentifier: String {
        return "ProductCartCellViewIdentifier"
    }

    class var nibName: String {
        return "ProductCartCellView"
    }

    func configureCell(product: Product, presenter: ShoppingCartPresenterProtocol?) {
        self.product = product
        self.presenter = presenter
        nameProductLbl.text = product.title
        categoriaProductLbl.text = product.category
        priceProductLbl.text = "$ \(product.price)"
        ratingProduct.rating = product.rate
        amountProductTFl.text = "\(product.count)"
        ImageLoader.loadImage(image: imageProduct, imageURL: product.image ?? "")
        
    }
    
    
    @IBAction func actionAddition(_ sender: Any) {
        
        presenter?.updateAmountProduct(product: product!, operation: .addition)
    }
    
    
    @IBAction func actionSubtraction(_ sender: Any) {
        
        presenter?.updateAmountProduct(product: product!, operation: .subtraction)
    }
    
    @IBAction func actionDelete(_ sender: UIButton) {
        
        presenter?.deleteProduct(by: Int(product?.id ?? 0))
    }
    
    
    
}
