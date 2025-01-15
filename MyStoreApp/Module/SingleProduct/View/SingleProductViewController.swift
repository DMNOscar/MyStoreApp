//
//  SingleProduct.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 10/01/25.
//

import UIKit
import Cosmos

class SingleProductViewController : BaseViewController{
    
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var containerInfoProduct: UIView!
    @IBOutlet weak var nameProductLbl: UILabel!
    @IBOutlet weak var priceProductLbl: UILabel!
    @IBOutlet weak var ratingProduct: CosmosView!
    @IBOutlet weak var containerAddCart: UIView!
    @IBOutlet weak var descriptionProductLbl: UILabel!
    @IBOutlet weak var amountProductTxtF: UITextField!
    
    var presenter: SingleProductPresenterProtocol?
    
    required init(presenter: SingleProductPresenterProtocol) {
        super.init(nibName: SingleProductViewController.typeName, bundle: Bundle(for: type(of: self)))
        
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        containerInfoProduct.layer.cornerRadius = 40
        containerInfoProduct.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerInfoProduct.layer.masksToBounds = true
        containerAddCart.layer.cornerRadius = 10
        containerAddCart.layer.masksToBounds = true
//        containerAddCart.applyShadow()
        presenter?.updateUI()
        
    }
    
    @IBAction func actionAddition(_ sender: UIButton) {
        presenter?.updateAmountProduct(operation: .addition)
    }
    
    @IBAction func actionSubtraction(_ sender: Any) {
        presenter?.updateAmountProduct(operation: .subtraction)
    }
    
    @IBAction func actionAddCart(_ sender: UIButton) {
        
        presenter?.saveProduct()
    }
    
}

extension SingleProductViewController: SingleProductViewProtocol{
    
    func updateAmountProduct(amount: Int) {
        amountProductTxtF.text = "\(amount)"
    }
    
    
    func updateUI(product: ProductElement) {
        ImageLoader.loadImage(image: imageProduct, imageURL: product.image ?? "")
        nameProductLbl.text = product.title
        priceProductLbl.text = "$\(product.price ?? 0)"
        ratingProduct.rating = product.rating?.rate ?? 0
        descriptionProductLbl.text = product.description
    }
    
    
     
}
