//
//  AppTabBar.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import UIKit
import Combine

typealias AppTabs = (
    home: UIViewController,
    cart: UIViewController
)

class AppTabsController: UITabBarController {
    internal var cancellables = Set<AnyCancellable>()
    internal let monitorQueue = DispatchQueue(label: "monitor")
    
    init(tabs: AppTabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [
            tabs.home,
            tabs.cart
          
        ]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
        //self.navigationController?.isNavigationBarHidden = true
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9.0)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        tabBar.tintColor = UIColor.init(named: "Primary")
        tabBar.isTranslucent = false
        tabBar.backgroundColor = UIColor.init(named: "MenuBackground")
        tabBar.unselectedItemTintColor = UIColor.init(named: "BackIcon")
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.init(named: "MenuBackground")
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
    }
}

extension AppTabsController: UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        (viewController as? UINavigationController)?.popToRootViewController(animated: true)
        return true
    }
    
}
