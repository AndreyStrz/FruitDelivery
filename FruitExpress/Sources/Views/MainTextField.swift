//
//  MainTextField.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 18.08.2024.
//

import SwiftUI

struct MainTextField: View {
    private var text: Binding<String>
    private let placeholder: String
    
    init(
        text: Binding<String>,
        placeholder: String
    ) {
        self.text = text
        self.placeholder = placeholder
    }
        
    var body: some View {
        TextField("",
                  text: text,
                  prompt: Text(placeholder)
                            .font(FontPalette.search.font)
                            .foregroundColor(ColorPalette.buttonText.color)
        )
        .textCase(.uppercase)
        .font(FontPalette.search.font)
        .foregroundColor(ColorPalette.buttonText.color)
        .padding(24)
        .background(
            RoundedRectangle(
                cornerSize: .init(width: 20, height: 20)
            )
            .foregroundColor(Color.white)
            .shadow(color: ColorPalette.shadowColor.color, radius: 3, x: 2, y: 4)
        )
        .overlay(
            RoundedRectangle(
                cornerSize: .init(width: 20, height: 20)
            )
            .stroke(ColorPalette.buttonBackground.color, lineWidth: 1)
        )
    }
}

#Preview {
    MainTextField(
        text: .constant("123"), 
        placeholder: "Search..."
    )
    .padding(20)
    .background(Color.red)
}
