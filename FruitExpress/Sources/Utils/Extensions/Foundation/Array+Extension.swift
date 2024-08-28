//
//  Array + Extension.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

extension Array {
    static var empty: Self {
        return .init()
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

extension Sequence where Element: Hashable {
    var asSet: Set<Element> {
        return Set(self)
    }
}

extension Sequence{
    var asArray: Array<Element> {
        return Array(self)
    }
}

public protocol CopyableViewModel {
    var copy: Self { get }
}

extension Array: CopyableViewModel where Element: CopyableViewModel {
    public var copy: [Element] {
        return map(\.copy)
    }
}
