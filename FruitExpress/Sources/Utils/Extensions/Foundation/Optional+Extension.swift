//
//  Optional + Extension.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation

extension Optional {
    // MARK: - isNil
    var isNil: Bool {
        switch self {
        case .some:
            return false
        case .none:
            return true
        }
    }
    
    var isNotNil: Bool {
        switch self {
        case .some:
            return true
        case .none:
            return false
        }
    }
    
    // MARK: - Or
    public func or(_ valueBlock: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? valueBlock()
    }
    
    public func or(_ valueBlock: @autoclosure () -> Wrapped?) -> Self {
        return self ?? valueBlock()
    }
    
    // MARK: - Take if
    public func takeIf(_ conditionBlock: (Wrapped) -> Bool) -> Self {
        switch self {
        case .some(let value):
            return conditionBlock(value) ? value : nil
        case .none:
            return nil
        }
    }
    
    public func takeIf(_ conditionBlock: @autoclosure () -> Bool) -> Self {
        switch self {
        case .some(let value):
            return conditionBlock() ? value : nil
        case .none:
            return nil
        }
    }
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}

extension Optional where Wrapped: AdditiveArithmetic {
    var orZero: Wrapped {
        return self ?? .zero
    }
}
