//
//  HomeRepository.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//
import Foundation
import PromiseKit
import Alamofire

public class HomeRepository: HomeRepositoryProtocol {

    // MARK: - Methods
    public init() {}
    
    public func getAllProducts() -> Promise<ProductsResponse> {
        return Session.requestWithPromise(HomeAPI.getAllProducts)
    }
    
    public func getCategories() -> Promise<CategoryResponse> {
        return Session.requestWithPromise(HomeAPI.getCategories)
    }
    
    public func getProductsByCategory(name: String) -> PromiseKit.Promise<ProductsResponse> {
        return Session.requestWithPromise(HomeAPI.getProductsByCategory(name))
    }
}
