//
//  FavoritesModuleBuilder.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 19.08.2024.
//

import Foundation

extension FavoritesViewController {
    public static func instantiate() -> FavoritesViewController {
        let view: FavoritesViewController = .init()
        let viewModel: FavoritesViewModel = .init()
        let router: FavoritesRouter = .init(viewController: view)
        let presenter: FavoritesPresenter = .init(view: view, router: router, viewModel: viewModel)
        
        view.presenter = presenter
        view.viewModel = viewModel
        
        return view
    }
}
