//
//  HomeRepositoryProtocol.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import PromiseKit

public protocol HomeRepositoryProtocol {
    func getAllProducts() -> Promise<ProductsResponse>
    func getCategories() -> Promise<CategoryResponse>
    func getProductsByCategory(name: String) -> Promise<ProductsResponse> 
}
