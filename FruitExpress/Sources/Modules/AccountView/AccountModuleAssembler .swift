//
//  AccountModuleAssembler .swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 22.08.2024.
//

import UIKit
import SwiftUI

extension AccountScreen {
    static func buildModule() -> UIHostingController<AccountScreen> {
        let viewModel: AccountViewModel = .init()
        let view: AccountScreen = .init(viewModel: viewModel)
        let viewController: UIHostingController<AccountScreen> = .init(rootView: view)
        viewModel.router = AccountRouter(viewController: viewController)
        
        return viewController
    }
}

protocol AccountRouterInput {
    func logOutButtonClicked()
    func deleteAccoountButtonClicked()
    
}

final class AccountRouter: AccountRouterInput {
    weak var viewController: UIViewController!
    
    private var productsStorage: ProductDomainModelStorage = .init()
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func logOutButtonClicked() {
        viewController.mainTabBarController?.openTab(kind: .main)
        RootViewController.shared.moduleInput.finishMainFlow()
        
        let updatedProducts = productsStorage.read().map { product in
            var newProduct = product
            newProduct.isFavorite = false
            productsStorage.store(item: newProduct)
        }
    }
    
    func deleteAccoountButtonClicked() {
        viewController.mainTabBarController?.openTab(kind: .main)
        RootViewController.shared.moduleInput.finishMainFlow()
        
        let updatedProducts = productsStorage.read().map { product in
            var newProduct = product
            newProduct.isFavorite = false
            productsStorage.store(item: newProduct)
        }
    }
    
}
