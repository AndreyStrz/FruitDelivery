//
//  OnboardingViewModel.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 13.08.2024.
//

import Foundation

final class OnboardingViewModel {
    var router: OnboardingRouterInput!
    let title: String

    init(title: String) {
        self.title = title
    }
    
    
    public static func == (lhs: OnboardingViewModel, rhs: OnboardingViewModel) -> Bool {
        return lhs.title == rhs.title
    }
}

extension OnboardingViewModel {
    func startButtonClicked() {
        router.startButtonClicked()
    }
    
    func loadData() {
        router.loadData()
    }
}
