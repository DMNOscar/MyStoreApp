//
//  TabBarRouter.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import Foundation
import UIKit

class TabBarRouter {

    var controller: UIViewController

    typealias SubModules = (
        home: UIViewController,
        cart: UIViewController
    )

    init(controller: UIViewController) {
        self.controller = controller
    }
}

extension TabBarRouter {

    static func tabs(usingSubModules submodules: SubModules) -> AppTabs {

        let targetSize = CGSize(width: 25, height: 25)

        let homeTabBarItem = UITabBarItem(
            title: "HOME",
            image: UIImage(named: "ic_home")?.scalePreservingAspectRatio(targetSize: targetSize),
            tag: 11
        )
        
        let cartTabBarItem = UITabBarItem(
            title: "CART",
            image: UIImage(named: "ic_cart")?.scalePreservingAspectRatio(targetSize: targetSize),
            tag: 12
        )

        submodules.home.tabBarItem = homeTabBarItem
        submodules.cart.tabBarItem = cartTabBarItem
    

        return (
            home: submodules.home,
            cart: submodules.cart
        )
    }
}
