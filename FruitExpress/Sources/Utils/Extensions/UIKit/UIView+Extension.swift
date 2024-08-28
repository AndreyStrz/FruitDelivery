//
//  UIView + Extension.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

extension UIView {
    func addConstrainted(subview: UIView, with insets: UIEdgeInsets = .zero) {
        addSubview(subview)
        apply(constraints: insets, to: subview)
    }
    
    func insertConstrainted(subview: UIView, at index: Int, with insets: UIEdgeInsets = .zero) {
        insertSubview(subview, at: index)
        apply(constraints: insets, to: subview)
    }
    
    private func apply(constraints: UIEdgeInsets, to subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: constraints.top),
            rightAnchor.constraint(equalTo: subview.rightAnchor, constant: constraints.right),
            bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: constraints.bottom),
            subview.leftAnchor.constraint(equalTo: leftAnchor, constant: constraints.left),
        ])
    }
}


