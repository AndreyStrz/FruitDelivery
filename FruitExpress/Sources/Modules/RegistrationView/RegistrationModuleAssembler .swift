//
//  RegistrationModuleAssembler .swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 22.08.2024.
//

import UIKit
import SwiftUI

extension RegistrationScreen {
    static func buildModule() -> UIHostingController<RegistrationScreen> {
        let viewModel: RegistrationViewModel = .init()
        let view: RegistrationScreen = .init(viewModel: viewModel)
        let viewController: UIHostingController<RegistrationScreen> = .init(rootView: view)
        viewModel.router = RegistrationRouter(viewController: viewController)
        
        return viewController
    }
}

protocol RegistrationRouterInput {
    func signUpButtonClicked()
    func haveAccountClicked()
}

@MainActor
final class RegistrationRouter: RegistrationRouterInput {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func signUpButtonClicked() {
        RootViewController.shared.moduleInput.finishAuthorizationFlow()
    }
    
    func haveAccountClicked() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
