//
//  ThankYouPageViewModel.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation

final class ThankYouPageViewModel {
    var router: ThankYouPageRouterInput!
    
    let id: String
    let image: String
    let title: String
    
    private let memoryDataBase: MemoryDataBase = .shared

    init(id: String, image: String, title: String) {
        self.id = id
        self.image = image
        self.title = title
    }
    
    public static func == (lhs: ThankYouPageViewModel, rhs: ThankYouPageViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.image == rhs.image &&
            lhs.title == rhs.title
    }
}

extension ThankYouPageViewModel {
    func okButtonClicked() {
        clearBasket()
        router.okButtonClicked()
    }
    
    private func clearBasket() {
        memoryDataBase.productsInBasket = []
    }
}
