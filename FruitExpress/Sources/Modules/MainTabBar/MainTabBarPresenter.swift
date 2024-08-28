//
//  MainTabBarPresenter.swift
//  QRCodeReader
//
//  Created by Андрей Сторожко on 04.06.2024.
//

import Foundation

protocol MainTabBarViewOutput: AnyObject {
    func viewDidLoad()
    
    func didTapOnMainButton()
    func didTapOnBasketButton()
    func didTapOnFavoriteButton()
    func didTapOnAccountButton()
}

final class MainTabBarPresenter {
    private weak var view: MainTabBarViewInput!
    private let router: MainTabBarRouterInput!
    
    private var selectedItem: MainTabBarItemKind = .main
    
    init(
        view: MainTabBarViewInput!,
        router: MainTabBarRouterInput
    ) {
        self.view = view
        self.router = router
    }
}

extension MainTabBarPresenter: MainTabBarViewOutput {
    func viewDidLoad() {
        view.select(item: selectedItem)
        router.showMainScreen()
    }
    
    func didTapOnMainButton() {
        if selectedItem != .main {
            selectedItem = .main
            view.select(item: .main)
            router.showMainScreen()
        } else {
            router.popToRootCurrentFlow()
        }
    }
    
    func didTapOnBasketButton() {
        if selectedItem != .basket {
            selectedItem = .basket
            view.select(item: .basket)
            router.showBasketScreen()
        } else {
            router.popToRootCurrentFlow()
        }
    }
    
    func didTapOnFavoriteButton() {
        if selectedItem != .favorite {
            selectedItem = .favorite
            view.select(item: .favorite)
            router.showFavoriteScreen()
        } else {
            router.popToRootCurrentFlow()
        }
    }
    
    func didTapOnAccountButton() {
        if selectedItem != .account {
            selectedItem = .account
            view.select(item: .account)
            router.showAccountScreen()
        } else {
            router.popToRootCurrentFlow()
        }
    }
}
