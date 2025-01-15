//
//  HomePreseter.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import UIKit

class HomePresenter: HomePresenterProtocol {
    
    var interactor: HomeInteractor
    var router: HomeRouter
    var view: HomeViewProtocol?
    
    var productsList: ProductsResponse = []
    var categoryList: [String] = []
    
    init(interactor: HomeInteractor, router: HomeRouter){
        self.interactor = interactor
        self.router = router
        getCategories()
    }
    
    func getProductsList(){
        interactor.getAllProductsList()
    }
    
    func onSuccessAllProductsList(response: ProductsResponse) {
        productsList = response
        view?.updateProductList()
    }
    
    func onFailedAllProductsList(errorResponse: any Error) {
        Snackbar.showSnackbar(title: "No es posible obtener la lista de productos", type: .error, icon: UIImage(named: "ic_cart"))
    }
    
    func getProductsListSize() -> Int{
        return  productsList.count
    }
    
    func getProduct(index: Int)->ProductElement{
        
        return productsList[index]
    }
    
    func showSingleProduct(index: Int){
        router.showSingleProduct(product: productsList[index])
    }
    
    
    func getCategories() {
        interactor.getCategories()
    }
    
    func onSuccessGetCategories(response: CategoryResponse) {
        categoryList = response
        categoryList.insert("All", at: 0)
        view?.updateView()
    }
    
    func onFailedGetCategories(errorResponse: any Error) {
        Snackbar.showSnackbar(title: "No es posible obtener la lista de categorias", type: .error, icon: UIImage(named: "ic_cart"))
  
    }
    
    
    func getCategoriesListSize() -> Int{
        return categoryList.count
    }
    func getCategory(index: Int) -> String{
        return categoryList[index]
    }
    
    
    func getProductsByCategory(index: Int){
        if index == 0{
            interactor.getAllProductsList()
        }else{
            interactor.getProductsByCategory(name: categoryList[index])
        }
    }
    
}
