//
//  ProductCellView.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 10/01/25.
//

import UIKit
import Kingfisher
import ImageIO
import Cosmos

class ProductCellView : UICollectionViewCell{
    
    @IBOutlet weak var nameProductLbl: UILabel!
    
    @IBOutlet weak var priceProductLbl: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!

    @IBOutlet weak var ratingProduct: CosmosView!
    class var reuseIdentifier: String {
        return "ProductCellViewIdentifier"
    }

    class var nibName: String {
        return "ProductCellView"
    }

    func configureCell(product: ProductElement) {
        
        nameProductLbl.text = product.title
        priceProductLbl.text = "$ \(product.price ?? 0)"
        ratingProduct.rating = product.rating?.rate ?? 0
        ratingProduct.text = "\(product.rating?.rate ?? 0)"
        ImageLoader.loadImage(image: imageProduct, imageURL: product.image ?? "")
    }
}
