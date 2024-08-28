//
//  FontPalette.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 18.08.2024.
//

import SwiftUI

enum FontPalette {
    case hTwo
    case hThree
    case sign
    case search
    
    var font: Font {
        switch self {
        case .hTwo:
            return .system(size: 48, weight: .heavy)
        case .hThree:
            return .system(size: 38, weight: .bold)
        case .sign:
            return .system(size: 32, weight: .heavy)
        case .search:
            return .system(size: 32, weight: .bold)
        }
    }
}

