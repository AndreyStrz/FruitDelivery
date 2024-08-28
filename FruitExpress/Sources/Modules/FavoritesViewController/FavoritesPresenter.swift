//
//  FavoritesPresenter.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 19.08.2024.
//

import Foundation

protocol FavoritesPresenterProtocol {
    func viewDidLoad()
    func pushToDetailProduct(id: String)
    func didTapOnOrderButton(id: String)
    func didTapOnFavoriteButton(id: String)
}

class FavoritesPresenter {
    var view: FavoritesViewControllerProtocol
    private let router: FavoritesRouterProtocol
    private var viewModel: FavoritesViewModel
    
    var productsStorage: ProductDomainModelStorage = .init()
    private var products: [ProductDomainModel] = []
    private var memoryDataBase: MemoryDataBase = .shared
    
    init(view: FavoritesViewControllerProtocol!, router: FavoritesRouterProtocol, viewModel: FavoritesViewModel) {
        self.view = view
        self.router = router
        self.viewModel = viewModel
    }
    
}


extension FavoritesPresenter: FavoritesPresenterProtocol {
    func viewDidLoad() {
        products = productsStorage.read()
        
        products.removeAll { product in
            product.isFavorite == false
        }
        
        viewModel.dataSource.inject(
            section: .init(
                id: .productCell,
                items: products.compactMap { makeCellViewModel(for: $0, size: viewModel.cellSize) },
                interitemSpacing: viewModel.spacingBetweenItems,
                lineSpacing: viewModel.spacingBetweenItems
            )
        )
        
        view.reloadDataSource()
    }
    
    func pushToDetailProduct(id: String) {
        guard let product = products.first(where: { $0.id.uuidString == id }) else {
            return
        }
        
        router.pushToDetailProduct(product: .init(id: product.id, image: product.image, title: product.title, price: product.price, isFavorite: product.isFavorite, descriptions: product.descriptions))
    }
    
    func didTapOnOrderButton(id: String) {
        guard let product = products.first(where: { $0.id.uuidString == id }) else {
            return
        }
        
        memoryDataBase.appendToBasket(product: product)
        router.pushToBasket()
    }
    
    func didTapOnFavoriteButton(id: String) {
        guard var product = products.first(where: { $0.id.uuidString == id }) else {
            return
        }
        var productIsFavorite: Bool = product.isFavorite
        productIsFavorite.toggle()

        product.isFavorite = productIsFavorite
        productsStorage.store(item: product)
        
        viewDidLoad()
    }
}

extension FavoritesPresenter {
    func makeCellViewModel(
        for model: ProductDomainModel,
        size: CGSize
    ) -> FavoritesKindCellViewModel? {
        return .productCell(
            .init(
                id: "\(model.id)",
                image: .init(named: model.image)!,
                title: model.title,
                isFavorite: model.isFavorite,
                size: size
            )
        )
    }
}
