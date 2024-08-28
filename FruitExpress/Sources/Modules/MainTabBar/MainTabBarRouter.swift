//
//  MainTabBarRouter.swift
//  QRCodeReader
//
//  Created by Андрей Сторожко on 04.06.2024.
//

import UIKit

protocol MainTabBarRouterInput {
    func showMainScreen()
    func showBasketScreen()
    func showFavoriteScreen()
    func showAccountScreen()
    func popToRootCurrentFlow()
}

final class MainTabBarRouter: MainTabBarRouterInput {
    private weak var viewController: MainTabBarViewController!
    
    init(viewController: MainTabBarViewController) {
        self.viewController = viewController
    }
    
    func showMainScreen() {
        if let currentViewController = viewController.currentViewController {
            viewController.remove(child: currentViewController)
        }
        
        viewController.add(child: viewController.mainViewController, container: viewController.contentContainerView)
        viewController.currentViewController = viewController.mainViewController
    }
    
    func showBasketScreen() {
        if let currentViewController = viewController.currentViewController {
            viewController.remove(child: currentViewController)
        }
        
        viewController.add(child: viewController.basketViewController, container: viewController.contentContainerView)
        viewController.currentViewController = viewController.basketViewController
    }
    
    func showFavoriteScreen() {
        if let currentViewController = viewController.currentViewController {
            viewController.remove(child: currentViewController)
        }
        
        viewController.add(child: viewController.favoritesViewController, container: viewController.contentContainerView)
        viewController.currentViewController = viewController.favoritesViewController
    }
    
    func showAccountScreen() {
        if let currentViewController = viewController.currentViewController {
            viewController.remove(child: currentViewController)
        }
        
        viewController.add(child: viewController.accountViewController, container: viewController.contentContainerView)
        viewController.currentViewController = viewController.accountViewController
    }
    
    func popToRootCurrentFlow() {
        guard let currentViewController = viewController.currentViewController as? UINavigationController else {
            return
        }
        
        currentViewController.popToRootViewController(animated: true)
    }
}


extension UIViewController {
    var mainTabBarController: MainTabBarViewController? {
        var cursor: UIViewController? = parent
        
        while let parent = cursor {
            if let navigationController = parent as? UINavigationController,
               let tabBarViewController = navigationController.viewControllers.first as? MainTabBarViewController {
                return tabBarViewController
            }
            else if let tabBarViewController = parent as? MainTabBarViewController {
                return tabBarViewController
            }
            
            cursor = parent.parent
        }
        
        return nil
    }
}
