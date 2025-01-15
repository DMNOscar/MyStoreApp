//
//  SingleProductProtocols.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 10/01/25.
//

protocol SingleProductInteractorProtocol: AnyObject {
    
    func saveProduct(product: ProductElement, amoutProduct: Int)
    
}

protocol SingleProductRouterProtocol: AnyObject {
    
}

protocol SingleProductPresenterProtocol: AnyObject {
    
    func updateUI()
    func updateAmountProduct(operation: ProductOperation)
    
    
    
    func saveProduct()
    func onSuccessSaveProduct()
    func onFailedSaveProduct(errorResponse: Error)
    
    
}

protocol SingleProductViewProtocol: AnyObject {
    
    func updateUI(product: ProductElement)
    func updateAmountProduct(amount: Int)
    
}
