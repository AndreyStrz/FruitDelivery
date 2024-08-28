//
//  BaseDataSource.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation

import UIKit

// MARK: - Data Source
public struct BaseDataSource<ID: Hashable, Header: BaseHeaderViewModel, Cell: BaseCellViewModel, Footer: BaseFooterViewModel> {
    public typealias SectionViewModel = BaseSectionViewModel<ID, Header, Cell, Footer>
    
    private(set) public var sections: [SectionViewModel] = []
    private var sectionPriorityHandler: SectionPriorityHandler<ID>
    
    var isEmpty: Bool {
        return sections.isEmpty
    }
    
    var count: Int {
        return sections.count
    }
    
    init(sectionPriorityHandler: SectionPriorityHandler<ID> = .init()) {
        self.sectionPriorityHandler = sectionPriorityHandler
    }
    
    public subscript(_ index: Int) -> SectionViewModel {
        return sections[index]
    }
    

        
    public mutating func inject(section: SectionViewModel) {
        if let index = sections.firstIndex(where: { $0.id == section.id }) {
            sections[index] = section
        } else {
            let sectionPriority: Int = sectionPriorityHandler.priority(for: section.id)
            
            if let index = sections.firstIndex(where: { sectionPriority < sectionPriorityHandler.priority(for: $0.id) }) {
                sections.insert(section, at: index)
            } else {
                sections.append(section)
            }
        }
    }
    
    public mutating func replaceAll(sections: [SectionViewModel]) {
        self.sections.removeAll()
        var exictedIds: Set<ID> = []
        
        for section in sections {
            if !exictedIds.contains(section.id) {
                exictedIds.insert(section.id)
                self.sections.append(section)
            } else {
                BaseSectionViewModelLogger.onErrorLog?("Found collision item in base data source", [
                    "method": #function,
                    "section": "\(section.id)",
                    "item": "\(type(of: self))"
                ])
            }
        }
    }
    
    public mutating func removeSection(id: ID) {
        guard let index = sections.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        sections.remove(at: index)
    }
}

// MARK: - Diffable
extension BaseDataSource {
    public typealias DiffableDataSource = UICollectionViewDiffableDataSource<SectionViewModel, LinkedCellViewModel<ID, Cell>>
    public typealias DiffableSnapshot = NSDiffableDataSourceSnapshot<SectionViewModel, LinkedCellViewModel<ID, Cell>>
    
    public var snapshot: DiffableSnapshot {
        var snapshot: DiffableSnapshot = .init()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.innerItems, toSection: section)
        }
        
        return snapshot
    }
}

// you can use it for data sources without priority
// by default it is data source with single section
open class SectionPriorityHandler<ID> {
    open func priority(for id: ID) -> Int {
        return 0
    }
}
