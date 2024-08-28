//
//  MainModuleBuilder .swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import Foundation

extension MainViewController {
    public static func instantiate() -> MainViewController {
        let view: MainViewController = .init()
        let viewModel: MainViewModel = .init()
        let router: MainRouter = .init(viewController: view)
        let presenter: MainPresenter = .init(view: view, router: router, viewModel: viewModel)
        
        view.presenter = presenter
        view.viewModel = viewModel
        
        return view
    }
}
