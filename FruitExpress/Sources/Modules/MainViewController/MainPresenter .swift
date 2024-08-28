//
//  MainPresenter .swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import Foundation

protocol MainPresenterProtocol {
    func viewDidLoad()
    func pushToDetailProduct(id: String)
    func searchFieldUpdated(text: String)
    func didTapOnOrderButton(id: String)
    func didTapOnFavoriteButton(id: String)
}

class MainPresenter {
    var view: MainViewControllerProtocol
    private let router: MainRouterProtocol
    private var viewModel: MainViewModel
    
    private var productsStorage: ProductDomainModelStorage = .init()
    private var products: [ProductDomainModel] = []
    private var memoryDataBase: MemoryDataBase = .shared
    
    init(view: MainViewControllerProtocol!, router: MainRouterProtocol, viewModel: MainViewModel) {
        self.view = view
        self.router = router
        self.viewModel = viewModel
    }
}


extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        reloadData()
    }
    
    func pushToDetailProduct(id: String) {
        guard let product = products.first(where: { $0.id.uuidString == id }) else {
            return
        }
        
        viewModel.searchText = ""
        router.pushToDetailProduct(product: .init(id: product.id, image: product.image, title: product.title, price: product.price, isFavorite: product.isFavorite, descriptions: product.descriptions))
    }
    
    func didTapOnOrderButton(id: String) {
        guard let product = products.first(where: { $0.id.uuidString == id }) else {
            return
        }
        
        viewModel.searchText = ""
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
        
        if viewModel.searchText.isNotEmpty {
            reloadData(searchProduct: viewModel.searchText)
        } else {
            reloadData()
        }
    }
    
    func searchFieldUpdated(text: String) {
        guard viewModel.searchText != text else { return }
        viewModel.searchText = text
        reloadData(searchProduct: text)
//        viewModel.searchText = ""
    }
}

// MARK: - Utils
private extension MainPresenter {
    func reloadData(searchProduct: String = "") {
        products = productsStorage.read()
        
        if searchProduct.isNotEmpty {
            products = products.filter { $0.title.lowercased().contains(searchProduct.lowercased()) }
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
}

extension MainPresenter {
    func makeCellViewModel(
        for model: ProductDomainModel,
        size: CGSize
    ) -> MainKindCellViewModel? {
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
