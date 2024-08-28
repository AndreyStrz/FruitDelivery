//
//  RootViewController.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import UIKit
import SwiftUI

final class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewControllers.last?.preferredStatusBarStyle ?? .default
    }
    
    private func initialSetup() {
        navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 19),
            .foregroundColor: UIColor.black
        ]
        
        navigationBar.backgroundColor = .clear
        
        navigationBar.tintColor = .black
        
        // keep back swipe when add custom back button
        interactivePopGestureRecognizer?.delegate = nil
    }
}

extension UIViewController {
    func getRootViewController() -> RootViewController? {
        var cursor = parent
        while let unwrapped = cursor {
            if let vc = unwrapped as? RootViewController {
                return vc
            } else {
                cursor = unwrapped.parent
            }
        }
        
        return nil
    }
}

protocol RootViewControllerProtocol {
    
}

class RootViewController: UIViewController, Containerable {
    
    lazy var containerView: UIView = {
        let result: UIView = .init()
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    lazy var onboardingViewController: UINavigationController = {
        let rootViewController: UIHostingController<OnboardingView> = OnboardingView.buildModule()
        let navigationController: UINavigationController = .init(rootViewController: rootViewController)
        navigationController.navigationBar.isHidden = true

        return navigationController
    }()
    

    lazy var authorizationViewController: UINavigationController = {
        let rootViewController: UIHostingController<AuthorizationView> = AuthorizationView.buildModule()
        let navigationController: UINavigationController = .init(rootViewController: rootViewController)
        navigationController.navigationBar.isHidden = true

        return navigationController
    }()

    lazy var mainViewController: UIViewController = {
        return BaseNavigationController(
            rootViewController: MainTabBarViewController.instantiate()
        )
    }()
    
    var currentViewController: UIViewController!
    
    public var moduleInput: RootModuleInput!
    public var presenter: RootPresenterProtocol!
    
    static let shared = RootViewController()
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        presenter.viewDidLoad()
    }
    
    private func initialSetup() {
        containerView.backgroundColor = .cyan
        
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
    }
}

extension RootViewController: RootViewControllerProtocol {
    
}
