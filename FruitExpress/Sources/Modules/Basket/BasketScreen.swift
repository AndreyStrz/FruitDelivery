//
//  BasketScreen.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import SwiftUI


struct BasketScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: BasketViewModel
    
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        currentView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
            .onAppear {
                viewModel.reloadDataSource()
            }
    }
    
    @ViewBuilder var currentView: some View {
        if viewModel.items.isNotEmpty {
            contentView
        } else {
            emptyView
        }
    }
    
    var contentView: some View {
        VStack {
            ZStack {
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ForEach(viewModel.items, id: \.self) { item in
                            BasketItemView(content: item) {
                                viewModel.itemPlusButtonClicked(item: item)
                            } onMinusTap: {
                                viewModel.itemMinusButtonClicked(item: item)
                            } onCloseTap: {
                                viewModel.itemCloseButtonClicked(item: item)
                            }

                        }
                    }
                    .padding(.vertical, 32)
                    .padding(.horizontal, 24)
                }
                
                VStack {
                  Spacer()
                  MainButton(
                    text: "CONTINUE \n \(viewModel.items.reduce(0) { $0 + ($1.price * $1.count) })",
                    fullWidth: false,
                    fontPalette: .hThree,
                    layout: .regular,
                    action: {
                        viewModel.continueButtonClicked()
                    }
                  )
                  .padding(.bottom, 48)
                  .padding(.horizontal, 36)
                }
                .padding(.bottom, -96)
            }
            .background(
                RoundedRectangle(
                    cornerSize: .init(width: 24, height: 24)
                )
                .foregroundStyle(Color.init(uiColor: .init(red: 254, green: 248, blue: 234, alpha: 1)))
                .shadow(color: ColorPalette.shadowColor.color, radius: 3, x: 2, y: 4)
            )
            .overlay(
                RoundedRectangle(
                    cornerSize: .init(width: 24, height: 24)
                )
                .stroke(.clear, lineWidth: 1)
            )
            .padding(.horizontal, 24)
            .padding(.vertical, 120)
        }
    }
    
    var emptyView: some View {
        VStack {
            Spacer()
            MainButton(
                text: "SELECT PRODUCT",
                fullWidth: true,
                fontPalette: .hThree,
                layout: .regular,
                action: {
                    viewModel.selectProductButtonClicked()
                }
            )
            .padding(.bottom, 48)
            .padding(.horizontal, 36)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    BasketScreen(viewModel: .init(items: [.init(id: "1", image: "plus", title: "shoto tam", price: 2, count: 1)]))
}


