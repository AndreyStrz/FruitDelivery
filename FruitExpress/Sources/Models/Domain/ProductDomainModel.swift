//
//  ProductDomainModel.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation
import RealmSwift
import UIKit

struct ProductDomainModel {
    var id: UUID
    var image: String
    var title: String
    var price: Int
    var isFavorite: Bool
    var descriptions: String
        
    init(
        id: UUID = .init(),
        image: String,
        title: String = "",
        price: Int = 0,
        isFavorite: Bool = false,
        descriptions: String = ""
    ) {
        self.id = id
        self.image = image
        self.title = title
        self.price = price
        self.isFavorite = isFavorite
        self.descriptions = descriptions
    }
}
