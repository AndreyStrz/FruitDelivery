//
//  UINavigationController + Extension.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

extension UINavigationController {
    
    func makeBackTabBarButton(target: Any?) {
        let b = UIView() //доделать
        b.backgroundColor = .init(white: 1, alpha: 0.2)
        b.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            b.widthAnchor.constraint(equalToConstant: 44),
            b.heightAnchor.constraint(equalToConstant: 44)
        ])
        let barb: UIBarButtonItem = .init(customView: b)
        b.isUserInteractionEnabled = true
        b.addGestureRecognizer(UITapGestureRecognizer(target: target, action: #selector(backButtonPressed)))
        navigationItem.leftBarButtonItem = barb
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

