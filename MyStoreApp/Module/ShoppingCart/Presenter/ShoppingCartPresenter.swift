//
//  ShoppingCartPresenter.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 13/01/25.
//

import UIKit

class ShoppingCartPresenter : ShoppingCartPresenterProtocol{
    

    var interactor: ShoppinCartInteractor
    var router: ShoppinCartRouterProtocol
    var view: ShoppingCartViewProtocol?
    var productsList: [Product] = []
    
    init(interactor: ShoppinCartInteractor, router: ShoppinCartRouterProtocol) {
        self.interactor = interactor
        self.router = router
        getShoppinCart()
    }
    
    func getCartSize() -> Int{
        return productsList.count
    }
    
    func getShoppinCart() {
        interactor.getShoppinCart()
    }
    
    func onSuccessGetShoppinCart(response: [Product]) {
        productsList = response
        updateData()
        view?.loadListCart()
    }
    
    func onFailedGetShoppinCart(errorResponse: any Error) {
        
    }
    
    func getProduct(index: Int)-> Product{
        return productsList[index]
    }

    
    func onSuccessSaveProduct() {
        interactor.getShoppinCart()
    }
    
    func onFailedSaveProduct(errorResponse: any Error) {
        
    }
    
    func deleteProduct(by id: Int) {
        
        interactor.deleteProduct(by: id)
    }
    
    func onSuccessDeleteProduct() {
        Snackbar.showSnackbar(title: "Producto eliminado", type: .success, icon: UIImage(named: "ic_delete"))
        getShoppinCart()
    }
    
    func onFailedDeleteProduct(errorResponse: any Error) {
        Snackbar.showSnackbar(title: "Error al eliminar", type: .error, icon: UIImage(named: "ic_delete"))
        getShoppinCart()
    }
    
    func updateProduct(id: Int, newCount: Int) {
       
    }
    
    func onSuccessUpdateProduct() {
        
    }
    
    func onFailedUpdateProduct(errorResponse: any Error) {
        
    }
    
    func updateData(){
        
        let totalProducts = productsList.reduce(0) { $0 + ($1.count) }
        let totalPrice = productsList.reduce(0.0) { $0 + ($1.price * Double($1.count)) }

        
        view?.updateData(size: Int(totalProducts) , total: String(format: "%.2f", totalPrice))
    }
    
    func updateAmountProduct(product: Product,operation: ProductOperation) {
        
        switch(operation){
            
        case .subtraction:
            
            if (product.count > 1){
                product.count = product.count - 1
                
            }
            
        case .addition:
            product.count = product.count + 1
            
        }
        interactor.updateProduct(id: Int(product.id), newCount: Int(product.count))
        getShoppinCart()
    }
    
}
