//
//  BaseCellViewModel.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

// MARK: - Cell
public protocol BaseCellViewModel: Identifiable, Hashable {
    var size: CGSize { get }
    var height: CGFloat { get }
}

extension BaseCellViewModel {
    public var height: CGFloat {
        return size.height
    }
}

extension BaseCellViewModel {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Linked Cell View Model
// It's wrapper for cell view models to combine id with section id.
// It makes possible to use duplicate ids in different section.
// And you have to contain unique cell ids only in section.
public struct LinkedCellViewModel<SectionID: Hashable, Element: BaseCellViewModel> {
    private let sectionID: SectionID
    public let source: Element
    
    init(sectionID: SectionID, source: Element) {
        self.sectionID = sectionID
        self.source = source
    }
}

// MARK: - BaseCellViewModel
extension LinkedCellViewModel: BaseCellViewModel {
    public var id: Element.ID {
        return source.id
    }
    
    public var size: CGSize {
        return source.size
    }
}

extension LinkedCellViewModel: CopyableViewModel where Element: CopyableViewModel {
    public var copy: LinkedCellViewModel<SectionID, Element> {
        return copy()
    }
    
    func copy(sectionID: SectionID? = nil, source: Element? = nil) -> Self {
        return .init(
            sectionID: sectionID ?? self.sectionID,
            source: source ?? self.source.copy
        )
    }
}

// MARK: - Hashable
extension LinkedCellViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(sectionID)
        hasher.combine(source.id)
    }
}

// MARK: - Equatable
extension LinkedCellViewModel: Equatable {
    public static func == (lhs: LinkedCellViewModel, rhs: LinkedCellViewModel) -> Bool {
        return lhs.sectionID == rhs.sectionID && lhs.source == rhs.source
    }
}
