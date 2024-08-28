//
//  MainTabBarModuleBuilder.swift
//  QRCodeReader
//
//  Created by Андрей Сторожко on 04.06.2024.
//

import UIKit

extension MainTabBarViewController {
    static func instantiate() -> MainTabBarViewController {
        let viewController: MainTabBarViewController = .init()
        let router: MainTabBarRouter = .init(viewController: viewController)
        let presenter: MainTabBarPresenter = .init(
            view: viewController,
            router: router
        )
        
        viewController.presenter = presenter
        
        return viewController
    }
}
