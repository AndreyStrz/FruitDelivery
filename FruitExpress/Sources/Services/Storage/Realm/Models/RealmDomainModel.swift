//
//  RealmDomainModel.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation
import RealmSwift

final class RealmDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var image: String = ""
    @Persisted var title: String = ""
    @Persisted var price: Int = 0
    @Persisted var isFavorite: Bool = false
    @Persisted var descriptions: String = ""
        
    convenience init(
        id: UUID = .init(),
        image: String,
        title: String,
        price: Int,
        isFavorite: Bool,
        descriptions: String
    ) {
        self.init()
        self.id = id
        self.image = image
        self.title = title
        self.price = price
        self.isFavorite = isFavorite
        self.descriptions = descriptions
    }
}
