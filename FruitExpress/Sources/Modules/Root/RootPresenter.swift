//
//  RootPresenter.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import Foundation

protocol RootPresenterProtocol {
    func viewDidLoad()
}

protocol RootModuleInput {
    func finishOnboardingFlow()
    func finishAuthorizationFlow()
    func finishMainFlow()
    func popToRootCurrentFlow()
}

class RootPresenter: RootPresenterProtocol, RootModuleInput {
    var view: RootViewControllerProtocol
    private let router: RootRouterProtocol
    
    let sessionManager: SessionManager = .shared
    
    init(view: RootViewControllerProtocol, router: RootRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        router.showOnboardingScreen()
        
//        if sessionManager.currentUser.isNotNil {
//            router.showMainScreen()
//        } else {
//            router.showAuthorizationScreen()
//        }
    }
    
    func finishOnboardingFlow() {
        if sessionManager.isLoggedIn {
            router.showMainScreen()
        } else {
            router.showAuthorizationScreen()
        }
    }
    
    func finishAuthorizationFlow() {
        router.showMainScreen()
    }
    
    func finishMainFlow() {
        router.showAuthorizationScreen()
    }
    
    func popToRootCurrentFlow() {
        router.popToRootCurrentFlow()
    }
}

