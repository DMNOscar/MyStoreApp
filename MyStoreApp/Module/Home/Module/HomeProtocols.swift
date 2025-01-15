//
//  HomeProtocols.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//


protocol HomeInteractorProtocol : AnyObject{
    
    func getAllProductsList()
    func getCategories()
    
    func getProductsByCategory(name: String)
    
}
protocol HomeRouterProtocol : AnyObject{
    func showSingleProduct(product: ProductElement)
}
protocol HomeViewProtocol : AnyObject{
    func updateView()
    func updateProductList()
    
}

protocol HomePresenterProtocol : AnyObject{
    
    func getProductsList()
    func onSuccessAllProductsList(response: ProductsResponse)
    func onFailedAllProductsList(errorResponse: Error)
    
    func getCategories()
    func onSuccessGetCategories(response: CategoryResponse)
    func onFailedGetCategories(errorResponse: Error)
    
    
    func getProductsListSize() -> Int
    func getProduct(index: Int) -> ProductElement
    func showSingleProduct(index: Int)
    
    
    func getCategoriesListSize() -> Int
    func getCategory(index: Int) -> String
    func getProductsByCategory(index: Int)
}


