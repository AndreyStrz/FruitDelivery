//
//  PlacingOrderView.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import SwiftUI

struct PlacingOrderScreen: View {
    // MARK: - Setup
    private var viewModel: PlacingOrderViewModel
    
    init(viewModel: PlacingOrderViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var name: String = ""
    @State private var address: String = ""
    
    @State private var date = Date()
    let dateFormatter = DateFormatter()

    var body: some View {
        VStack(spacing: 20) {
            MainTextField(text: $name, placeholder: "NAME...")
            MainTextField(text: $address, placeholder: "ADDRESS...")
            HStack(spacing: 8) {
                Text(date.toString("dd.MM.yyy"))
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: .date
                        )
                        .blendMode(.destinationOver)
                    }
                    .foregroundStyle(ColorPalette.buttonText.color)
                    .padding(16)
                    .background(
                        RoundedRectangle(
                            cornerSize: .init(width: 16, height: 16)
                        )
                        .foregroundStyle(Color.white)
                        .shadow(color: ColorPalette.shadowColor.color, radius: 3, x: 2, y: 4)
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerSize: .init(width: 16, height: 16)
                        )
                        .stroke(.clear, lineWidth: 1)
                    )
                    .labelsHidden()
                    .datePickerStyle(.compact)

                Text(date.toString("HH:mm"))
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: .hourAndMinute
                        )
                        .blendMode(.destinationOver)
                    }
                    .foregroundStyle(ColorPalette.buttonText.color)
                    .padding(16)
                    .background(
                        RoundedRectangle(
                            cornerSize: .init(width: 16, height: 16)
                        )
                        .foregroundStyle(Color.white)
                        .shadow(color: ColorPalette.shadowColor.color, radius: 3, x: 2, y: 4)
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerSize: .init(width: 16, height: 16)
                        )
                        .stroke(.clear, lineWidth: 1)
                    )
                    .labelsHidden()
                    .datePickerStyle(.compact)
            }

            MainButton(text: "CONFIRM", fullWidth: true, fontPalette: .sign, layout: .regular) {
                viewModel.confirmButtonClicked()
            }
        }
        .padding(.horizontal, 36)
        .padding(.vertical, 230)
        .background(
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
        )
    }
}

#Preview {
    PlacingOrderScreen(viewModel: .init(id: "1"))
}
