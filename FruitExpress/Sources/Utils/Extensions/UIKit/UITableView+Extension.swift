//
//  UITableView + Extension.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

// MARK: - UITableView
extension UITableView {
    // MARK: Cell
    public func registerCell<T: UITableViewCell & Reusable>(class type: T.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    public func registerCell<T: UITableViewCell & NibReusable>(nib type: T.Type) {
        register(type.nib, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell & Reusable>(type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell: T = dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Table Cell: \(type.reuseIdentifier) is not registered")
        }
        
        return cell
    }
    
    // MARK: Section
    public func registerHeaderView<T: UITableViewHeaderFooterView & Reusable>(class type: T.Type) {
        register(type, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }
    
    public func registerHeaderView<T: UITableViewHeaderFooterView & NibReusable>(nib type: T.Type) {
        register(type.nib, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }

    public func registerFooterView<T: UITableViewHeaderFooterView & Reusable>(class type: T.Type) {
        register(type, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }

    public func registerFooterView<T: UITableViewHeaderFooterView & NibReusable>(nib type: T.Type) {
        register(type.nib, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }

    public func dequeueReusableHeaderView<T: UITableViewHeaderFooterView & Reusable>(type: T.Type) -> T {
        guard let header: T = dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier) as? T else {
            fatalError("Table Header: \(type.reuseIdentifier) is not registered")
        }
        
        return header
    }
    
    public func dequeueReusableFooterView<T: UITableViewHeaderFooterView & Reusable>(type: T.Type) -> T {
        guard let header: T = dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier) as? T else {
            fatalError("Table Footer: \(type.reuseIdentifier) is not registered")
        }
        
        return header
    }
}

// MARK: - UITableViewDiffableDataSource
extension UITableViewDiffableDataSource {
    // MARK: Base
    public func sectionViewModel(at section: Int) -> SectionIdentifierType? {
        return snapshot().sectionIdentifiers[safe: section]
    }
    
    public func itemViewModel(in section: SectionIdentifierType, at index: Int) -> ItemIdentifierType? {
        return snapshot().itemIdentifiers(inSection: section)[safe: index]
    }

    public func itemViewModel(at indexPath: IndexPath) -> ItemIdentifierType? {
        let snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType> = snapshot()

        return snapshot.sectionIdentifiers[safe: indexPath.section].flatMap { section in
            return snapshot.itemIdentifiers(inSection: section)[safe: indexPath.item]
        }
    }

    public func itemViewModels(at indexPaths: [IndexPath]) -> [ItemIdentifierType] {
        return indexPaths.compactMap(itemViewModel(at:))
    }

    public var allItemViewModels: [ItemIdentifierType] {
        return snapshot().itemIdentifiers
    }
    
    // MARK: BaseDataSource based
    public convenience init<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel>(
        for tableView: UITableView,
        cellProvider: @escaping (UITableView, IndexPath, Cell) -> UITableViewCell?
    ) where SectionIdentifierType == BaseSectionViewModel<ID, Header, Cell, Footer>, ItemIdentifierType == LinkedCellViewModel<ID, Cell> {
        self.init(tableView: tableView, cellProvider: { tableView, indexPath, cellViewModel in
            cellProvider(tableView, indexPath, cellViewModel.source)
        })
    }
        
    public func itemHeight(
        for indexPath: IndexPath,
        defaultValue: CGFloat = 1
    ) -> CGFloat where ItemIdentifierType: BaseCellViewModel {
        return itemViewModel(at: indexPath).map(\.height) ?? defaultValue
    }
    
    public func headerHeight<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel>(
        for section: Int,
        defaultValue: CGFloat = 0
    ) -> CGFloat where SectionIdentifierType == BaseSectionViewModel<ID, Header, Cell, Footer> {
        return sectionViewModel(at: section).flatMap(\.header?.height) ?? defaultValue
    }
    
    public func footerSize<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel>(
        for section: Int,
        defaultValue: CGFloat = 0
    ) -> CGFloat where SectionIdentifierType == BaseSectionViewModel<ID, Header, Cell, Footer> {
        return sectionViewModel(at: section).flatMap(\.footer?.height) ?? defaultValue
    }
}


