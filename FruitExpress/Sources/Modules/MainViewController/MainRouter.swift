//
//  MainRouter .swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import Foundation
import UIKit
import SwiftUI

protocol MainRouterProtocol {
    func pushToDetailProduct(product: ProductDomainModel)
    func pushToBasket()
}

class MainRouter: MainRouterProtocol {
    private weak var viewController: MainViewController!
    
    init(viewController: MainViewController) {
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
