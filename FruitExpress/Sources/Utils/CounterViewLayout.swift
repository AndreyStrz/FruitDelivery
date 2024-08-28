//
//  CounterViewLayout.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 21.08.2024.
//

import Foundation

public struct CounterViewLayout {
    // MARK: - Properties
    let contentVerticalPadding: CGFloat
    let contentHorizontalPadding: CGFloat
    
    init(
        contentVerticalPadding: CGFloat,
        contentHorizontalPadding: CGFloat
    ) {
        self.contentVerticalPadding = contentVerticalPadding
        self.contentHorizontalPadding = contentHorizontalPadding
    }
}

// MARK: - Catalog values
public extension CounterViewLayout {
    static let counter: CounterViewLayout = CounterViewLayout(
        contentVerticalPadding: 2,
        contentHorizontalPadding: 42
    )
    
    static let main: CounterViewLayout = CounterViewLayout(
        contentVerticalPadding: 16,
        contentHorizontalPadding: 42
    )
    static let onboarding: CounterViewLayout = CounterViewLayout(
        contentVerticalPadding: 24,
        contentHorizontalPadding: 42
    )
}
