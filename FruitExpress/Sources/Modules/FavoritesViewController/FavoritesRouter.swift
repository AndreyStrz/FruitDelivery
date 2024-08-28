//
//  FavoritesRouter.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 19.08.2024.
//

import Foundation
import SwiftUI

protocol FavoritesRouterProtocol {
    func pushToDetailProduct(product: ProductDomainModel)
    func pushToBasket()
}

class FavoritesRouter: FavoritesRouterProtocol {
    private weak var viewController: FavoritesViewController!
    
    init(viewController: FavoritesViewController) {
        self.viewController = viewController
    }
    
    func pushToDetailProduct(product: ProductDomainModel) {
        let rootViewController: UIHostingController<ProductDetailsScreen> = ProductDetailsScreen.buildModule(product: .init(id: product.id.uuidString, title: product.title, image: product.image, price: product.price, isFavorite: product.isFavorite, description: product.descriptions))
        
        viewController?.navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func pushToBasket() {
        viewController.mainTabBarController?.openTab(kind: .basket)
    }
}
