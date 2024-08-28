//
//  HostingView.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import SwiftUI
import UIKit

public final class HostingView<Content: View>: UIView {
    public let content: Content
    
    public init(content: Content) {
        self.content = content
        super.init(frame: .zero)
        
        let hostingController: UIHostingController = .init(rootView: content)
        
        backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        addSubview(hostingController.view)

        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: leftAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
            hostingController.view.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
