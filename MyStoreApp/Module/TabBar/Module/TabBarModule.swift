//
//  TabBarModule.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import Foundation
import UIKit

struct TabBarModule {

    static func build(usingSubModules submodules: TabBarRouter.SubModules) -> UITabBarController {
        let tabs = TabBarRouter.tabs(usingSubModules: submodules)
        let tabBarController = AppTabsController(tabs: tabs)
        return tabBarController
    }
}
