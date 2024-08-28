//
//  CounterView.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 19.08.2024.
//

import SwiftUI

struct CounterView: View {
    private var text: String
    private let layout: CounterViewLayout
    
    init(text: String, layout: CounterViewLayout) {
        self.text = text
        self.layout = layout
    }
    
    var body: some View {
        HStack {
            Text(text)
                .bold()
                .foregroundColor(ColorPalette.buttonText.color)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.horizontal, layout.contentHorizontalPadding)
                .padding(.vertical, layout.contentVerticalPadding)
                .background(
                    RoundedRectangle(
                        cornerSize: .init(width: 24, height: 24)
                    )
                    .foregroundColor(Color.white)
                    .shadow(color: ColorPalette.shadowColor.color, radius: 3, x: 2, y: 4)
                )
                .overlay(
                    RoundedRectangle(
                        cornerSize: .init(width: 24, height: 24)
                    )
                    .stroke(.clear, lineWidth: 1)
                )
        }
    }
}

#Preview {
    CounterView(text: "123", layout: .main)
}
