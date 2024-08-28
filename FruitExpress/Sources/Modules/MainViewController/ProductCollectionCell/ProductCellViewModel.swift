//
//  ProductCellViewModel.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import UIKit

struct ProductCellViewModel: BaseCellViewModel {
    let layout: ProductCellViewLayout
    let id: String
    let image: UIImage
    let title: String
    let isFavorite: Bool

    let size: CGSize
    
    init(
        layout: ProductCellViewLayout = .init(),
        id: String,
        image: UIImage,
        title: String,
        isFavorite: Bool,
        size: CGSize
    ) {
        self.layout = layout
        self.id = id
        self.image = image
        self.title = title
        self.isFavorite = isFavorite
        self.size = size
    }
}

extension ProductCellViewModel: Equatable {
    static func == (lhs: ProductCellViewModel, rhs: ProductCellViewModel) -> Bool {
        return KeyPathEqualizer(lhs: lhs, rhs: rhs)
            .compare(by: \.id)
            .compare(by: \.image)
            .compare(by: \.title)
            .compare(by: \.isFavorite)
            .build()
    }
}
