//
//  NavigationFactory.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

class NavigationBuilder : NSObject, UIApplicationDelegate {
    
    static func build(rootView: UIViewController) -> UINavigationController {
        
       
        let navigationController = UINavigationController(
            rootViewController: rootView
        )
        navigationController.navigationBar.backgroundColor = .systemBackground
        navigationController.navigationBar.barTintColor = .label
        navigationController.navigationBar.tintColor = .label
        
        navigationController.navigationBar.isTranslucent = true
        
        
        return navigationController
    }
}
