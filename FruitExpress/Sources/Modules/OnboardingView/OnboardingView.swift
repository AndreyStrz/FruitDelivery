//
//  OnboardingView.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 13.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Setup    
    private var viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            CounterView(text: viewModel.title, layout: .onboarding)
            MainButton(text: "START", fullWidth: true, fontPalette: .hTwo, layout: .regular) {
                viewModel.startButtonClicked()
            }
            .padding(.bottom, 80)
        }
        .padding(.top, 160)
        .padding(.horizontal, 36)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
        )
        .onDisappear(perform: {
            viewModel.loadData()
        })
    }
}

#Preview {
    OnboardingView(viewModel: .init(title: "123123123123123123123123123123123123123123123123fldjjfdkjlf323982778947842378934783478389778324897738927894329787893247893497832424378987327832978784329782347834278782347823477823487873248327434287783248324832749392"))
}
