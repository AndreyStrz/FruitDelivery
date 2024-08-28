//
//  MainButton.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 18.08.2024.
//

import SwiftUI

struct MainButton: View {
    private let text: String
    private let fullWidth: Bool
    private let fontPalette: FontPalette
    private let layout: MainButtonLayout
    private let action: () -> Void
    
    init(
        text: String,
        fullWidth: Bool = false,
        fontPalette: FontPalette,
        layout: MainButtonLayout,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.fullWidth = fullWidth
        self.fontPalette = fontPalette
        self.layout = layout
        self.action = action
    }
        
    var body: some View {
        Button(
            action: {
                action()
            }, 
            label: {
                Text(text)
                    .lineLimit(2)
                    .font(fontPalette.font)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(ColorPalette.buttonText.color)
                    .if(fullWidth) {
                        $0.frame(maxWidth: .infinity)
                    }
            }
        )
        .padding(.horizontal, layout.contentHorizontalPadding)
        .padding(.vertical, layout.contentVerticalPadding)
        .background(
            RoundedRectangle(
                cornerSize: .init(width: 20, height: 20)
            )
            .foregroundColor(ColorPalette.buttonBackground.color)
            .shadow(color: ColorPalette.shadowColor.color, radius: 3, x: 2, y: 4)
        )
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MainButton(text: "test", fontPalette: .hTwo, layout: .regular, action: {})
//        .padding(.horizontal, 20)
}
