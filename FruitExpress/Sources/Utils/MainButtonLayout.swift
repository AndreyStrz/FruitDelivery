//
//  PaddingPalette.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 20.08.2024.
//

import Foundation
import SwiftUI

public struct MainButtonLayout {
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
public extension MainButtonLayout {
    static let regular: MainButtonLayout = MainButtonLayout(
        contentVerticalPadding: 16,
        contentHorizontalPadding: 24
    )
    
    static let sign: MainButtonLayout = MainButtonLayout(
        contentVerticalPadding: 16,
        contentHorizontalPadding: 48
    )
    
    static let logOut: MainButtonLayout = MainButtonLayout(
        contentVerticalPadding: 12,
        contentHorizontalPadding: 12
    )
}
