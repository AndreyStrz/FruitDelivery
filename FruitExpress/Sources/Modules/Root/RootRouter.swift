//
//  RootRouter.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import UIKit

protocol RootRouterProtocol {
    func showOnboardingScreen()
    func showAuthorizationScreen()
    func showMainScreen()
    func popToRootCurrentFlow()
}

final class RootRouter: RootRouterProtocol {
    private weak var viewController: RootViewController!
    
    init(viewController: RootViewController) {
        self.viewController = viewController
    }
        
    func showOnboardingScreen() {
        if let currentViewController = viewController.currentViewController {
            viewController.remove(child: currentViewController)
        }
        
        viewController.addWithAnimation(child: viewController.onboardingViewController, container: viewController.containerView)
        viewController.currentViewController = viewController.onboardingViewController
    }
    
    func showAuthorizationScreen() {
        if let currentViewController = viewController.currentViewController {
            viewController.remove(child: currentViewController)
        }
        
        viewController.addWithAnimation(child: viewController.authorizationViewController, container: viewController.containerView)
        viewController.currentViewController = viewController.authorizationViewController
    }
    
    func showMainScreen() {
        if let currentViewController = viewController.currentViewController {
            viewController.remove(child: currentViewController)
        }
        
        viewController.addWithAnimation(child: viewController.mainViewController, container: viewController.containerView)
        viewController.currentViewController = viewController.mainViewController
    }
    
    func popToRootCurrentFlow() {
        guard let currentViewController = viewController.currentViewController as? UINavigationController else {
            return
        }
        
        currentViewController.popToRootViewController(animated: true)
    }
}
