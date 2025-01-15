//
//  SingleProductPresenter.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 10/01/25.
//

import UIKit

class SingleProductPresenter: SingleProductPresenterProtocol{
    
    var interactor: SingleProductInteractor
    var router: SingleProductRouter
    var product: ProductElement
    var view: SingleProductViewProtocol?
    var amoutProduct = 1
   

    
    init(interactor: SingleProductInteractor, router: SingleProductRouter,  product: ProductElement){
        self.interactor = interactor
        self.router = router
        self.product = product
        
    }
    
    
    func updateUI(){
        view?.updateUI(product: product)
    }
    
    func updateAmountProduct(operation: ProductOperation) {
        
        switch(operation){
            
        case .subtraction:
            
            if (amoutProduct > 1){
                amoutProduct = amoutProduct - 1
                view?.updateAmountProduct(amount: amoutProduct )
            }
            
        case .addition:
            amoutProduct = amoutProduct + 1
            view?.updateAmountProduct(amount: amoutProduct )
        }
        
    }
    
 
    
    func saveProduct() {
        interactor.saveProduct(product: product, amoutProduct: amoutProduct)
    }
    
    func onSuccessSaveProduct() {
        Snackbar.showSnackbar(title: "Producto agrregado al carrito", type: .success, icon: UIImage(named: "ic_add_cart"))
    }
    
    func onFailedSaveProduct(errorResponse: any Error) {
        Snackbar.showSnackbar(title: "Error al agregar al carrito", type: .error, icon: UIImage(named: "ic_cart"))
    }
    
}
