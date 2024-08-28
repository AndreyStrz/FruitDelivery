//
//  UIEdgeInsets + Extension.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

extension UIEdgeInsets {
    var horizontal: CGFloat {
        return left + right
    }
    
    var vertical: CGFloat {
        return top + bottom
    }
}
