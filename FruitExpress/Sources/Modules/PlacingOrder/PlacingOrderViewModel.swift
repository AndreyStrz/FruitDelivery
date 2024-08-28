//
//  PlacingOrderViewContent.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation

final class PlacingOrderViewModel {
    var router: PlacingOrderRouterInput!
    let id: String

    init(id: String) {
        self.id = id
    }
    
    public static func == (lhs: PlacingOrderViewModel, rhs: PlacingOrderViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension PlacingOrderViewModel {
    func confirmButtonClicked() {
        router.confirmButtonClicked()
    }
}

