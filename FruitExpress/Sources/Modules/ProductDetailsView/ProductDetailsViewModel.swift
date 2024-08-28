//
//  ProductDetailsViewModel .swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation

final class ProductDetailsViewModel: ObservableObject {
    @Published var id: String
    @Published var title: String
    @Published var image: String
    @Published var price: Int
    @Published var isFavorite: Bool
    @Published var description: String
    
    var router: ProductDetailsRouterInput!
    private var memoryDataBase: MemoryDataBase = .shared

    init(id: String, title: String, image: String, price: Int, isFavorite: Bool, description: String) {
        self.id = id
        self.title = title
        self.image = image
        self.price = price
        self.isFavorite = isFavorite
        self.description = description
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: ProductDetailsViewModel, rhs: ProductDetailsViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.image == rhs.image &&
            lhs.price == rhs.price &&
            lhs.isFavorite == rhs.isFavorite &&
            lhs.description == rhs.description
    }
}

extension ProductDetailsViewModel {
    func orderButtonClicked() {
        let uuid = UUID(uuidString: id)
        
        if let uuid {
            memoryDataBase.appendToBasket(product: .init(id: uuid, image: image, title: title, price: price, isFavorite: isFavorite, descriptions: description))
        }
        
        router.orderButtonClicked()
    }
}
