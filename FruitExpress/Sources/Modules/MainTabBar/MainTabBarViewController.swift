//
//  MainTabBarViewController.swift
//  QRCodeReader
//
//  Created by Андрей Сторожко on 04.06.2024.
//

import UIKit
import SwiftUI

fileprivate struct Layout {
    static let tabBarBaseHeight: CGFloat = 60
    static let tabBarHeight: CGFloat = tabBarBaseHeight + UIDevice.current.safeAreaInsets.bottom
}

protocol MainTabBarViewInput: AnyObject {
    func select(item: MainTabBarItemKind)
}

final class MainTabBarViewController: UIViewController, Containerable {
    
    lazy var contentContainerView: UIView = {
        let result: UIView = .init()
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var stackViewContainerView: UIView = {
        let result: UIView = .init()
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var stackView: UIStackView = {
        let result: UIStackView = .init()
        result.distribution = .fillEqually
        result.spacing = view.bounds.width / 14
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var stackViewBackgroundImageView: UIImageView = {
        let result: UIImageView = .init()
        result.image = .init(named: "tabbarBackground")
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var mainButton: UIButton = {
        let result: UIButton = .init()
        result.setImage(.init(named: "apple"), for: .normal)
        result.imageView?.contentMode = .scaleAspectFit
        result.addTarget(self, action: #selector(didTapOnMainButton), for: .touchUpInside)
        result.translatesAutoresizingMaskIntoConstraints = false
        
        return result
    }()
    
    private lazy var basketButton: UIButton = {
        let result: UIButton = .init()
        result.setImage(.init(named: "cart"), for: .normal)
        result.imageView?.contentMode = .scaleAspectFit
        result.addTarget(self, action: #selector(didTapOnBasketButton), for: .touchUpInside)
        result.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint.activate([
//            result.heightAnchor.constraint(equalToConstant: 10),
//            result.widthAnchor.constraint(equalToConstant: 10)
//        ])
        return result
    }()
    
    private lazy var favoritesButton: UIButton = {
        let result: UIButton = .init()
        result.setImage(.init(named: "heart"), for: .normal)
        result.imageView?.contentMode = .scaleAspectFit
        result.addTarget(self, action: #selector(didTapOnFavoriteButton), for: .touchUpInside)
        result.translatesAutoresizingMaskIntoConstraints = false
        
        return result
    }()
    
    private lazy var accountButton: UIButton = {
        let result: UIButton = .init()
        result.setImage(.init(named: "like"), for: .normal)
        result.imageView?.contentMode = .scaleAspectFit
        result.addTarget(self, action: #selector(didTapOnAccountButton), for: .touchUpInside)
        result.translatesAutoresizingMaskIntoConstraints = false
        
        return result
    }()
    
    lazy var mainViewController: MainViewController = {
        return MainViewController.instantiate()
    }()
    
    lazy var basketViewController: UIViewController = {
        return BasketScreen.buildModule(items: [])
    }()
    
    lazy var favoritesViewController: FavoritesViewController = {
        return FavoritesViewController.instantiate()
    }()
    
    lazy var accountViewController: UIViewController = {
//        let currentUser = SessionManager.shared.currentUser
        return AccountScreen.buildModule()
    }()
    
    var currentViewController: UIViewController!
    
    var presenter: MainTabBarViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        presenter.viewDidLoad()
    }

    private func initialSetup() {
        view.addSubview(contentContainerView)
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            contentContainerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentContainerView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        view.addSubview(stackViewContainerView)
        NSLayoutConstraint.activate([
            stackViewContainerView.topAnchor.constraint(equalTo: contentContainerView.bottomAnchor),
            stackViewContainerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackViewContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackViewContainerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackViewContainerView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        
        stackViewContainerView.addSubview(stackViewBackgroundImageView)
        NSLayoutConstraint.activate([
            stackViewBackgroundImageView.topAnchor.constraint(equalTo: stackViewContainerView.topAnchor),
            stackViewBackgroundImageView.rightAnchor.constraint(equalTo: stackViewContainerView.rightAnchor),
            stackViewBackgroundImageView.bottomAnchor.constraint(equalTo: stackViewContainerView.bottomAnchor),
            stackViewBackgroundImageView.leftAnchor.constraint(equalTo: stackViewContainerView.leftAnchor)
        ])
        
        stackViewContainerView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: stackViewContainerView.topAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: stackViewContainerView.rightAnchor, constant: -48),
            stackView.bottomAnchor.constraint(equalTo: stackViewContainerView.bottomAnchor, constant: -16),
            stackView.leftAnchor.constraint(equalTo: stackViewContainerView.leftAnchor, constant: 48)
        ])
        
        stackView.addArrangedSubview(mainButton)
        stackView.addArrangedSubview(basketButton)
        stackView.addArrangedSubview(favoritesButton)
        stackView.addArrangedSubview(accountButton)
    }


    // MARK: - Actions
    @objc private func didTapOnMainButton() {
        presenter.didTapOnMainButton()
    }
    
    @objc private func didTapOnBasketButton() {
        presenter.didTapOnBasketButton()
    }
    
    @objc private func didTapOnFavoriteButton() {
        presenter.didTapOnFavoriteButton()
    }
    
    @objc private func didTapOnAccountButton() {
        presenter.didTapOnAccountButton()
    }
}

extension MainTabBarViewController: MainTabBarViewInput {
    func select(item: MainTabBarItemKind) {
        makeButtonStyle(button: mainButton, image: .init(named: "apple")!, isSelected: item == .main)
        makeButtonStyle(button: basketButton, image: .init(named: "cart")!, isSelected: item == .basket)
        makeButtonStyle(button: favoritesButton, image: .init(named: "heart")!, isSelected: item == .favorite)
        makeButtonStyle(button: accountButton, image: .init(named: "like")!, isSelected: item == .account)
    }
    
    // module input
    func openTab(kind: MainTabBarItemKind) {
        switch kind {
        case .main:
            didTapOnMainButton()
        case .basket:
            didTapOnBasketButton()
        case .favorite:
            didTapOnFavoriteButton()
        case .account:
            didTapOnAccountButton()
        }
    }
}

// MARK: - Helpers
private extension MainTabBarViewController {
    func makeButtonStyle(button: UIButton, image: UIImage, isSelected: Bool) {
        if !isSelected { //доделать
            button.setImage(image, for: .normal)
            button.tintColor = nil
        } else {
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = .red
        }
    }
}
