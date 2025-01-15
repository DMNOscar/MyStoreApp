//
//  HomeRouter.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import UIKit

class HomeRouter: HomeRouterProtocol{
    var view: UIViewController?
    
    func showSingleProduct(product: ProductElement){
        let single = SingleProductModule.build(product: product)
        view?.navigationController?.pushViewController(single, animated: true)
    }
}
