//
//  Header + Footer.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

// MARK: - Header
public protocol BaseHeaderViewModel: Identifiable, Hashable {
    var size: CGSize { get }
    var height: CGFloat { get }
}

extension BaseHeaderViewModel {
    public var height: CGFloat {
        return size.height
    }
}

// MARK: Hashable
extension BaseHeaderViewModel {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Footer
public protocol BaseFooterViewModel: Identifiable, Hashable {
    var size: CGSize { get }
    var height: CGFloat { get }
}

extension BaseFooterViewModel {
    public var height: CGFloat {
        return size.height
    }
}

// MARK: Hashable
extension BaseFooterViewModel {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
