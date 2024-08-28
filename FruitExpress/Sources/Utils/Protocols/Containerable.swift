//
//  Containerable.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

protocol Containerable {
    func add(child viewController: UIViewController, container: UIView)
    func remove(child viewController: UIViewController)
}

extension Containerable where Self: UIViewController {
    func add(child viewController: UIViewController, container: UIView) {
        
        addChild(viewController)
        container.addSubview(viewController.view)
        viewController.view.frame = container.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

    func addWithAnimation(child viewController: UIViewController, container: UIView, completion: (() -> Void)? = nil) {
        addChild(viewController)
        container.addSubview(viewController.view)
        UIView.transition(with: container, duration: 0.5, options: .transitionCrossDissolve, animations: {
            viewController.view.frame = container.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            viewController.didMove(toParent: self)
        }, completion: { _ in
            completion?()
        })
    }
    
    func add(
        child viewController: UIViewController,
        container: UIView,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        if animated {
            addWithAnimation(child: viewController, container: container, completion: completion)
        } else {
            add(child: viewController, container: container)
        }
    }

    func remove(child viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    func removeAll(from container: UIView) {
        for viewController in children where container.subviews.contains(viewController.view) {
            remove(child: viewController)
        }
    }
}
