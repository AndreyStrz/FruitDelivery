//
//  FavoritesViewModel.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 19.08.2024.
//

import Foundation

enum FavoritesSectionID: String, Hashable {
    case productCell
}

enum FavoritesKindCellViewModel: Hashable, BaseCellViewModel {
    case productCell(ProductCellViewModel)
    
    var id: some Hashable {
        switch self {
        case .productCell(let viewModel):
            return viewModel.id
        }
    }
    
    var size: CGSize {
        switch self {
        case .productCell(let viewModel):
            return viewModel.size
        }
    }
}

typealias FavoritesDataSource = BaseDataSource<FavoritesSectionID, Nothing, FavoritesKindCellViewModel, Nothing>

final class FavoritesViewModel {
    var viewSize: CGSize = .zero
    private(set) var collecitonViewSize: CGSize = .zero
    var cellSize: CGSize = .zero
    
    var dataSource: FavoritesDataSource = .init()
    
    let contentHeightWithoutCollectionView: CGFloat = 280
    let contentWidthWithoutCollectionView: CGFloat = 64
    
    let spacingBetweenItems: CGFloat = 6
    
    var currentPage: Int = 1
    
    func apply(collecitonViewSize: CGSize) {
        self.collecitonViewSize = collecitonViewSize
        self.cellSize = .init(
            width: floor((collecitonViewSize.width - spacingBetweenItems) / 2),
            height: floor((collecitonViewSize.height - (spacingBetweenItems * 2)) / 3)
        )
    }
}
