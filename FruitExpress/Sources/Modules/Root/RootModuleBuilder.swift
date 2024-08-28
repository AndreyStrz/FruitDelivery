//
//  RootModuleBuilder.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import Foundation

extension RootViewController {
    public static func instantiate() -> RootViewController {
        let view: RootViewController = .shared
        let router: RootRouter = .init(viewController: view)
        let presenter: RootPresenter = .init(view: view, router: router)

        view.presenter = presenter
        view.moduleInput = presenter
        
        return view
    }
}
