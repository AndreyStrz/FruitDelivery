//
//  MainViewModel .swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import Foundation

enum MainSectionID: String, Hashable {
    case productCell
}

enum MainKindCellViewModel: Hashable, BaseCellViewModel {
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

typealias MainDataSource = BaseDataSource<MainSectionID, Nothing, MainKindCellViewModel, Nothing>

final class MainViewModel {
    var viewSize: CGSize = .zero
    private(set) var collecitonViewSize: CGSize = .zero
    var cellSize: CGSize = .zero
    
    var dataSource: MainDataSource = .init()
    var searchText: String = ""
    
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
