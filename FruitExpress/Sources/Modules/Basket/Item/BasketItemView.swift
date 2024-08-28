//
//  BasketItemView.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import SwiftUI

struct BasketItemView: View {
    // MARK: - Setup
    public typealias Content = BasketItemViewContent
    private var memoryDataBase: MemoryDataBase = .shared
    
    private var content: Content
    private var onPlusTap: (() -> Void)?
    private var onMinusTap: (() -> Void)?
    private var onCloseTap: (() -> Void)?
    
    init(content: Content, onPlusTap: (() -> Void)? = nil, onMinusTap: (() -> Void)? = nil, onCloseTap: (() -> Void)? = nil) {
        self.content = content
        self.onPlusTap = onPlusTap
        self.onMinusTap = onMinusTap
        self.onCloseTap = onCloseTap
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(content.image)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(12)
                .background(
                    RoundedRectangle(
                        cornerSize: .init(width: 80, height: 80)
                    )
                    .foregroundStyle(Color.white)
                    .shadow(color: ColorPalette.shadowColor.color, radius: 3, x: 2, y: 4)
                )
                .overlay(
                    RoundedRectangle(
                        cornerSize: .init(width: 80, height: 80)
                    )
                    .stroke(.clear, lineWidth: 1)
                )
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(content.title)
                    Spacer()
                    Image("close")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            print("delete")
                            onCloseTap?()
                        }
                }
                HStack(spacing: 16) {
                    Text("\(content.price)")
                    Image("dimond")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                

                HStack(alignment: .center, spacing: 16) {
                    Button(action: {
                        onPlusTap?()
                    }, label: {
                        Image("plus")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .background( Circle()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundStyle(.white)
                            )
                    })
                    
                    Text(String(content.count))
                        .font(.title)
                    Button(action: {
                        onMinusTap?()
                    }, label: {
                        Image("minus")
                            .resizable()
                            .frame(width: 20, height: 4, alignment: .center)
                            .background( Circle()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundStyle(.white)
                            )
                    })
                }
                .padding(.top, 16)
                Rectangle()
                    .frame(height: 4)
                    .foregroundColor(.gray)
            }
            
            .padding(.top, 16)
        }
        .background(Color.clear)
    }
}

#Preview {
    BasketItemView(content: .init(id: "1", image: "plus", title: "KIWI", price: 3, count: 2), onCloseTap:  {
        print("OnboardingView")
    })
}
