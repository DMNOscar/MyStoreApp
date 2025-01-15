//
//  SigleProductModel.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 10/01/25.
//

import UIKit

struct SingleProductModule{
    
    static func build(product: ProductElement) -> UIViewController {
        
        let interactor = SingleProductInteractor(repository: ShoppingCartRepository())
        
        let router = SingleProductRouter()
        
        let presenter = SingleProductPresenter(interactor: interactor, router: router, product: product)
        
        let view = SingleProductViewController(presenter: presenter)
        
        router.view = view
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
    
}
