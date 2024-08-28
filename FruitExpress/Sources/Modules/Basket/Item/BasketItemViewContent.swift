//
//  BasketItemViewContent.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation

struct BasketItemViewContent: Hashable {
    let id: String
    let image: String
    let title: String
    let price: Int
    let count: Int

    init(id: String, image: String, title: String, price: Int, count: Int) {
        self.id = id
        self.image = image
        self.title = title
        self.price = price
        self.count = count
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: BasketItemViewContent, rhs: BasketItemViewContent) -> Bool {
        return lhs.id == rhs.id &&
            lhs.image == rhs.image &&
            lhs.title == rhs.title &&
            lhs.price == rhs.price &&
            lhs.count == rhs.count
    }
}
