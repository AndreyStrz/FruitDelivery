//
//  BasketModuleAssembler.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 19.08.2024.
//

import UIKit
import SwiftUI

extension BasketScreen {
    static func buildModule(items: [BasketItemViewContent]) -> UIHostingController<BasketScreen> {
        let viewModel: BasketViewModel = .init(items: items)
        let view: BasketScreen = .init(viewModel: viewModel)
        let viewController: UIHostingController<BasketScreen> = .init(rootView: view)
        viewModel.router = BasketRouter(viewController: viewController)
        
        return viewController
    }
}

protocol BasketRouterInput {
    func continueButtonClicked()
    func selectProductButtonClicked()
}

final class BasketRouter: BasketRouterInput {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func continueButtonClicked() {
        let placingOrderScreen: UIHostingController<PlacingOrderScreen> = PlacingOrderScreen.buildModule()
        
        viewController?.navigationController?.pushViewController(placingOrderScreen, animated: false)
    }
    
    func selectProductButtonClicked() {
        viewController?.mainTabBarController?.openTab(kind: .main)
    }
}
