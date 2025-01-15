//
//  HomeModule.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import UIKit
struct HomeModule{
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UINavigationController {
        
        let interactor = HomeInteractor(
            homerpository: HomeRepository()
        )
        
        let router = HomeRouter()
        
        let presenter = HomePresenter(
            interactor: interactor,
            router: router
        )
        
        let view = HomeViewController(homePresenter: presenter)
        
        router.view = view
        presenter.view = view
        interactor.homePresenter = presenter
        
        return factory(view)
    }
}
