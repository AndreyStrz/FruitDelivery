//
//  ColorPalette.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 18.08.2024.
//

import UIKit
import SwiftUI

enum ColorPalette {
    case buttonBackground
    case buttonText
    
    case shadowColor
    
    var uiColor: UIColor {
        switch self {
        case .buttonBackground:
            return .init(red: 252, green: 199, blue: 0, alpha: 1)
        case .buttonText:
            return .init(red: 8, green: 47, blue: 0, alpha: 1)
        case .shadowColor:
            return .init(white: 0, alpha: 0.7)
        }
    }
    
    var color: Color {
        return .init(uiColor: uiColor)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
}
