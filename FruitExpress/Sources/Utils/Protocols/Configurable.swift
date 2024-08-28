//
//  Configurable.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

// MARK: - Cell
public protocol ConfigurableCollectionCell {
    associatedtype ViewModel: BaseCellViewModel
    func configure(viewModel: ViewModel)
}

public extension UICollectionViewCell {
    func configure<Cell, ViewModel>(
        as cellType: Cell.Type,
        with viewModel: ViewModel,
        andApply modification: ((Cell) -> Void)? = nil
    ) where Cell: ConfigurableCollectionCell, Cell.ViewModel == ViewModel {
        guard let cell = self as? Cell else { return }
        
        modification?(cell)
        cell.configure(viewModel: viewModel)
    }
}

// MARK: - Header
public protocol ConfigurableCollectionHeader {
    associatedtype ViewModel: BaseHeaderViewModel
    func configure(viewModel: ViewModel)
}

public extension UICollectionReusableView {
    func configure<View, ViewModel>(
        as viewType: View.Type,
        with viewModel: ViewModel,
        andApply modification: ((View) -> Void)? = nil
    ) where View: ConfigurableCollectionHeader, View.ViewModel == ViewModel {
        guard let view = self as? View else {
            return
        }
        
        modification?(view)
        view.configure(viewModel: viewModel)
    }
}

// MARK: - Footer
public protocol ConfigurableCollectionFooter {
    associatedtype ViewModel: BaseFooterViewModel
    func configure(viewModel: ViewModel)
}

public extension UICollectionReusableView {
    func configure<View, ViewModel>(
        as viewType: View.Type,
        with viewModel: ViewModel,
        andApply modification: ((View) -> Void)? = nil
    ) where View: ConfigurableCollectionFooter, View.ViewModel == ViewModel {
        guard let view = self as? View else {
            return
        }
        
        modification?(view)
        view.configure(viewModel: viewModel)
    }
}
