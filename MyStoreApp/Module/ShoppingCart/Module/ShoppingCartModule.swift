//
//  ShoppingCartModule.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 13/01/25.
//

import UIKit

struct ShoppingCartModule{
    
    static func build(usingNavigationFactory factory: NavigationFactory)-> UINavigationController {
        
        let interactor = ShoppinCartInteractor(repository: ShoppingCartRepository())
        
        let router = ShoppingCartRouter()
        
        let presenter = ShoppingCartPresenter(interactor: interactor, router: router)
        
        let view = ShoppingCartViewController(presenter: presenter)
        
        router.view = view
        presenter.view = view
        interactor.presenter = presenter
        
        return factory(view)
    }
    
}
