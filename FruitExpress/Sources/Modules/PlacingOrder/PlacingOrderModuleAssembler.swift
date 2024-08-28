//
//  PlacingOrderModuleAssembler.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 22.08.2024.
//

import UIKit
import SwiftUI

extension PlacingOrderScreen {
    static func buildModule() -> UIHostingController<PlacingOrderScreen> {
        let viewModel: PlacingOrderViewModel = .init(id: "!")
        let view: PlacingOrderScreen = .init(viewModel: viewModel)
        let viewController: UIHostingController<PlacingOrderScreen> = .init(rootView: view)
        viewModel.router = PlacingOrderRouter(viewController: viewController)
        
        return viewController
    }
}

protocol PlacingOrderRouterInput {
    func confirmButtonClicked()
}

final class PlacingOrderRouter: PlacingOrderRouterInput {
    weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func confirmButtonClicked() {
        let thankYouPageScreen: UIHostingController<ThankYouPageScreen> = ThankYouPageScreen.buildModule()
        
        viewController?.navigationController?.pushViewController(thankYouPageScreen, animated: true)
    }
}
