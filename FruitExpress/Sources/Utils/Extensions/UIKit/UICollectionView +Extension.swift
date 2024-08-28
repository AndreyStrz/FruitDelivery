//
//  UICollectionView + Extension.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

// MARK: - UICollectionView
extension UICollectionView {
    // MARK: Cell
    public func registerCell<T: UICollectionViewCell & Reusable>(class type: T.Type) {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    public func registerCell<T: UICollectionViewCell & NibReusable>(nib type: T.Type) {
        register(type.nib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell & Reusable>(type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell: T = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Colleciton Cell: \(type.reuseIdentifier) is not registered")
        }
        
        return cell
    }
    
    // MARK: Section
    public func registerHeaderView<T: UICollectionReusableView & Reusable>(class type: T.Type) {
        register(type, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: type.reuseIdentifier)
    }
    
    public func registerHeaderView<T: UICollectionReusableView & NibReusable>(nib type: T.Type) {
        register(type.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: type.reuseIdentifier)
    }
    
    public func registerFooterView<T: UICollectionReusableView & Reusable>(class type: T.Type) {
        register(type, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: type.reuseIdentifier)
    }
    
    public func registerFooterView<T: UICollectionReusableView & NibReusable>(nib type: T.Type) {
        register(type.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: type.reuseIdentifier)
    }

    public func dequeueReusableHeaderView<T: UICollectionReusableView & Reusable>(type: T.Type, for indexPath: IndexPath) -> T {
        guard let header: T = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Colleciton Header: \(type.reuseIdentifier) is not registered")
        }
        
        return header
    }
    
    public func dequeueReusableFooterView<T: UICollectionReusableView & Reusable>(type: T.Type, for indexPath: IndexPath) -> T {
        guard let header: T = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Colleciton Footer: \(type.reuseIdentifier) is not registered")
        }
        
        return header
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView & Reusable>(ofKind kind: String, with type: T.Type, for indexPath: IndexPath) -> T {
        guard let header: T = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Colleciton \(kind): \(type.reuseIdentifier) is not registered")
        }
        
        return header
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension UICollectionViewDiffableDataSource {
    // MARK: Base
    public func sectionViewModel(at section: Int) -> SectionIdentifierType? {
        return snapshot().sectionIdentifiers[safe: section]
    }
    
    public func itemViewModel(in section: SectionIdentifierType, at index: Int) -> ItemIdentifierType? {
        return snapshot().itemIdentifiers(inSection: section)[safe: index]
    }
    
    public func itemViewModel<SectionID: Hashable, Cell: BaseCellViewModel>(
        in section: SectionIdentifierType,
        at index: Int
    ) -> Cell? where ItemIdentifierType == LinkedCellViewModel<SectionID, Cell> {
        return snapshot().itemIdentifiers(inSection: section)[safe: index]?.source
    }
    
    public func itemViewModel(at indexPath: IndexPath) -> ItemIdentifierType? {
        let snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType> = snapshot()
        
        return snapshot.sectionIdentifiers[safe: indexPath.section].flatMap { section in
            return itemViewModel(in: section, at: indexPath.item)
        }
    }
    
    public func itemViewModel<SectionID: Hashable, Cell: BaseCellViewModel>(
        at indexPath: IndexPath
    ) -> Cell? where ItemIdentifierType == LinkedCellViewModel<SectionID, Cell> {
        let snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType> = snapshot()
        
        return snapshot.sectionIdentifiers[safe: indexPath.section].flatMap { section in
            return itemViewModel(in: section, at: indexPath.item)
        }
    }
    
    public func itemViewModels(at indexPaths: [IndexPath]) -> [ItemIdentifierType] {
        return indexPaths.compactMap(itemViewModel(at:))
    }
    
    public var allItemViewModels: [ItemIdentifierType] {
        return snapshot().itemIdentifiers
    }
    
    // MARK: BaseDataSource based
    // input
    public convenience init<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel>(
        for collectionView: UICollectionView,
        cellProvider: @escaping (UICollectionView, IndexPath, Cell) -> UICollectionViewCell?
    ) where SectionIdentifierType == BaseSectionViewModel<ID, Header, Cell, Footer>, ItemIdentifierType == LinkedCellViewModel<ID, Cell> {
        self.init(collectionView: collectionView, cellProvider: { collectionView, indexPath, cellViewModel in
            cellProvider(collectionView, indexPath, cellViewModel.source)
        })
    }
    
    public func apply<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel>(
        headerProvider: ((UICollectionView, IndexPath, Header) -> UICollectionReusableView?)? = nil,
        footerProvider: ((UICollectionView, IndexPath, Footer) -> UICollectionReusableView?)? = nil
    ) where SectionIdentifierType == BaseSectionViewModel<ID, Header, Cell, Footer> {
        self.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionViewModel = self?.sectionViewModel(at: indexPath.section) else {
                return nil
            }
            
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerViewModel: Header = sectionViewModel.header else {
                    return nil
                }
                
                return headerProvider?(collectionView, indexPath, headerViewModel)
            } else {
                guard let footerViewModel: Footer = sectionViewModel.footer else {
                    return nil
                }
                
                return footerProvider?(collectionView, indexPath, footerViewModel)
            }
        }
    }
    
    // output
    public func insets<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel>(
        for section: Int,
        defaultValue: UIEdgeInsets = .zero
    ) -> UIEdgeInsets where SectionIdentifierType == BaseSectionViewModel<ID, Header, Cell, Footer> {
        return sectionViewModel(at: section).map(\.insets) ?? defaultValue
    }
    
    public func lineSpacing<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel>(
        for section: Int,
        defaultValue: CGFloat = .zero
    ) -> CGFloat where SectionIdentifierType == BaseSectionViewModel<ID, Header, Cell, Footer> {
        return sectionViewModel(at: section).map(\.lineSpacing) ?? defaultValue
    }
    
    public func interitemSpacing<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel>(
        for section: Int,
        defaultValue: CGFloat = .zero
    ) -> CGFloat where SectionIdentifierType == BaseSectionViewModel<ID, Header, Cell, Footer> {
        return sectionViewModel(at: section).map(\.interitemSpacing) ?? defaultValue
    }
    
    public func itemSize(
        for indexPath: IndexPath,
        defaultValue: CGSize = .init(width: 1, height: 1)
    ) -> CGSize where ItemIdentifierType: BaseCellViewModel {
        return itemViewModel(at: indexPath).map(\.size) ?? defaultValue
    }
    
    public func headerSize<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel>(
        for section: Int,
        defaultValue: CGSize = .init(width: 0, height: 0)
    ) -> CGSize where SectionIdentifierType == BaseSectionViewModel<ID, Header, Cell, Footer> {
        return sectionViewModel(at: section).flatMap(\.header?.size) ?? defaultValue
    }
    
    public func footerSize<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel>(
        for section: Int,
        defaultValue: CGSize = .init(width: 0, height: 0)
    ) -> CGSize where SectionIdentifierType == BaseSectionViewModel<ID, Header, Cell, Footer> {
        return sectionViewModel(at: section).flatMap(\.footer?.size) ?? defaultValue
    }
}
