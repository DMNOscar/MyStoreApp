//
//  ShoppinCartProtocols.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 13/01/25.
//

protocol ShoppinCartInteractorProtocol: AnyObject {
    
    func getShoppinCart()
    func deleteProduct(by id: Int)
    func updateProduct(id: Int, newCount: Int)
}

protocol ShoppinCartRouterProtocol: AnyObject {
    
}

protocol ShoppingCartPresenterProtocol: AnyObject {
    
    
    func getCartSize() -> Int
    func getProduct(index: Int) -> Product
    
    func getShoppinCart()
    func onSuccessGetShoppinCart(response: [Product])
    func onFailedGetShoppinCart(errorResponse: Error)
    
    func deleteProduct(by id: Int)
    func onSuccessDeleteProduct()
    func onFailedDeleteProduct(errorResponse: Error)
    
    
    func updateProduct(id: Int, newCount: Int)
    func onSuccessUpdateProduct()
    func onFailedUpdateProduct(errorResponse: Error)
    
    func updateAmountProduct(product: Product,operation: ProductOperation)
    
    
}

protocol ShoppingCartViewProtocol: AnyObject {
    
    func loadListCart()
    func updateData(size: Int, total: String)
    
}

