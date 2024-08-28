//
//  ThankYouPageScreen.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import SwiftUI

struct ThankYouPageScreen: View {
    // MARK: - Setup
    private var viewModel: ThankYouPageViewModel
    
    init(viewModel: ThankYouPageViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Image("userProfile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .shadow(color: .gray, radius: 3, x: 2, y: 2)
                .background(
                    Circle()
                        .fill(Color.init(uiColor: .init(red: 20, green: 46, blue: 7, alpha: 1)))
                        .frame(width: 240, height: 240)
                )
                .padding(.bottom, 36)
            Text(viewModel.title)
                .bold()
                .font(.title)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            MainButton(text: "OK", fullWidth: false, fontPalette: .sign, layout: .sign) {
                viewModel.okButtonClicked()
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 48)
        .background(
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
                .scaledToFill()
        )
    }
}

#Preview {
    ThankYouPageScreen(viewModel: .init(id: "1", image: "apple", title: "THANK YOU FOR ORDERING"))
}
