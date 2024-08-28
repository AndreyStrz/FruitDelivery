//
//  OnboardingModuleAssembler.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 20.08.2024.
//

import UIKit
import SwiftUI

extension OnboardingView {
    static func buildModule() -> UIHostingController<OnboardingView> {
        let viewModel: OnboardingViewModel = .init(title: "FRESH FRUIT TO YOUR TABLE. \nWIDE SELECTION, EXCELLENT QUALITY, FAST DELIVERY.\nENJOY HEALTH WITH US!")
        let view: OnboardingView = .init(viewModel: viewModel)
        let viewController: UIHostingController<OnboardingView> = .init(rootView: view)
        viewModel.router = OnboardingRouter(viewController: viewController)
        
        return viewController
    }
}

protocol OnboardingRouterInput {
    func startButtonClicked()
    func loadData()
}

final class OnboardingRouter: OnboardingRouterInput {
    weak var viewController: UIViewController?
    private let notesStorage: ProductDomainModelStorage = .init()
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func startButtonClicked() {        
        RootViewController.shared.moduleInput.finishOnboardingFlow()
    }
    
    func loadData() {
        guard notesStorage.read().isEmpty else { return }
        
        notesStorage.store(item: .init(image: "orange", title: "ORANGE", price: 1, isFavorite: false, descriptions: "A BRIGHT, JUICY CITRUS FRUIT WITH A RICH FLAVOR AND AROMA, PERFECT FOR FRESH JUICE AND A HEALTHY SNACK."))
        notesStorage.store(item: .init(image: "redApple", title: "RED APPLE", price: 2, isFavorite: false, descriptions: "A SWEET AND CRUNCHY APPLE WITH SMOOTH SKIN, RICH IN VITAMINS, GREAT FOR SNACKS OR SALADS."))
        notesStorage.store(item: .init(image: "greenApple", title: "GREEN APPLE", price: 3, isFavorite: false, descriptions: "A TANGY AND REFRESHING APPLE WITH CRISP FLESH, IDEAL FOR MORNING SMOOTHIES AND BAKING."))
        notesStorage.store(item: .init(image: "pinapple", title: "PINAPPLE", price: 4, isFavorite: false, descriptions: "AN EXOTIC FRUIT WITH JUICY, SWEET FLESH AND A SLIGHT TANG, ADDING A TROPICAL TOUCH TO DISHES."))
        notesStorage.store(item: .init(image: "watermalon", title: "WATERMALON", price: 3, isFavorite: false, descriptions: "A REFRESHING SUMMER FRUIT WITH JUICY, SWEET FLESH, PERFECT FOR PICNICS AND HOT DAYS."))
        notesStorage.store(item: .init(image: "pear", title: "PEAR", price: 2, isFavorite: false, descriptions: "A SWEET AND TENDER FRUIT WITH FRAGRANT FLESH, GREAT FOR SNACKS OR AS A DESSERT INGREDIENT."))
        
        notesStorage.store(item: .init(image: "bananas", title: "BANANAS", price: 1, isFavorite: false, descriptions: "A NUTRITIOUS FRUIT WITH SOFT, SWEET FLESH, PERFECT FOR SNACKS AND SMOOTHIES."))
        notesStorage.store(item: .init(image: "plum", title: "PLUM", price: 2, isFavorite: false, descriptions: "A JUICY FRUIT WITH TENDER, SWEET-TART FLESH, PERFECT FOR DESSERTS AND SNACKS."))
        notesStorage.store(item: .init(image: "grape", title: "GRAPE", price: 3, isFavorite: false, descriptions: "JUICY AND SWEET BERRIES, IDEAL FOR SNACKS, DESSERTS, AND FRESH JUICES."))
        notesStorage.store(item: .init(image: "melon", title: "MELON", price: 4, isFavorite: false, descriptions: "AROMATIC AND SWEET WITH REFRESHING FLESH, MELON IS THE PERFECT SUMMER FRUIT FOR COOLING SNACKS."))
        notesStorage.store(item: .init(image: "mango", title: "MANGO", price: 3, isFavorite: false, descriptions: "A JUICY AND SWEET TROPICAL FRUIT WITH BUTTERY FLESH, PERFECT FOR SALADS, DESSERTS, AND SMOOTHIES."))
        notesStorage.store(item: .init(image: "nectarine", title: "NECTARINE", price: 2, isFavorite: false, descriptions: "A JUICY FRUIT WITH SMOOTH SKIN AND SWEET FLESH, A GREAT CHOICE FOR SUMMER SNACKS AND DESSERTS."))
        
        notesStorage.store(item: .init(image: "kiwi", title: "KIWI", price: 1, isFavorite: false, descriptions: "A REFRESHING FRUIT WITH A VIBRANT, SWEET-TART FLAVOR, RICH IN VITAMIN C, PERFECT FOR SALADS AND SMOOTHIES."))
        notesStorage.store(item: .init(image: "passion", title: "PASSION FRUIT", price: 2, isFavorite: false, descriptions: "AN EXOTIC FRUIT WITH REFRESHING SWEET-TART PULP AND UNFORGETTABLE AROMA, GREAT FOR DESSERTS AND DRINKS."))
        notesStorage.store(item: .init(image: "peach", title: "PEACH", price: 3, isFavorite: false, descriptions: "A TENDER AND JUICY FRUIT WITH VELVETY SKIN AND SWEET FLESH, PERFECT FOR SUMMER SNACKS AND BAKING."))
        notesStorage.store(item: .init(image: "lime", title: "LIME", price: 4, isFavorite: false, descriptions: "A CITRUS FRUIT WITH A REFRESHING SOUR TASTE, PERFECT FOR DRINKS, MARINADES, AND SALADS."))
        notesStorage.store(item: .init(image: "strawberrie", title: "STRAWBERRIE", price: 3, isFavorite: false, descriptions: "A SWEET AND FRAGRANT BERRY WITH JUICY FLESH, PERFECT FOR DESSERTS, DRINKS, AND HEALTHY SNACKS."))
        notesStorage.store(item: .init(image: "tangerine", title: "tangerined", price: 2, isFavorite: false, descriptions: "A SWEET AND JUICY CITRUS FRUIT WITH A LIGHT AROMA, PERFECT FOR SNACKS AND FRESH JUICES."))
    }

}
