//
//  AccountScreen.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import SwiftUI
import WebKit

struct AccountScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: AccountViewModel
    
    @State private var isPresentWebView = false
    
    init(viewModel: AccountViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        contentView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
    }
    
    var contentView: some View {
        VStack() {
            HStack(spacing: 24) {
                Image("userProfile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(color: .gray, radius: 3, x: 2, y: 2)
                    .background(
                        Circle()
                            .fill(Color.init(uiColor: .init(red: 20, green: 46, blue: 7, alpha: 1)))
                            .frame(width: 140, height: 140)
                    )

                VStack(alignment: .leading, spacing: 12) {
                    CounterView(text: viewModel.name, layout: .main)
                        .lineLimit(2)
                    CounterView(text: viewModel.email, layout: .main)
                        .lineLimit(2)
                }
            }
            .padding(.top, 128)
            Spacer()
            VStack(spacing: 24) {
                Button(action: {
                    isPresentWebView = true
                }, label: {
                    Text("PRIVACY POLYCY")
                        .bold()
                        .foregroundStyle(.white)
                })
                .sheet(isPresented: $isPresentWebView) {
                    NavigationStack {
                        WebView(url: URL(string: "https://sites.google.com/view/fruitexpress/home")!)
                            .ignoresSafeArea()
                            .navigationTitle("Privacy Policy")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                MainButton(text: "LOG OUT", fullWidth: true, fontPalette: .hThree, layout: .logOut) {
                    viewModel.logOutButtonClicked()
                }
                Button(action: {
                    viewModel.deleteAccoountButtonClicked()
                }, label: {
                    Text("DELETE ACCOUNT")
                        .foregroundStyle(.white)
                        .bold()
                })
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 32)
        .onAppear {
            viewModel.reloadDataSource()
        }
    }
}
    

#Preview {
    AccountScreen(viewModel: .init(id: "1", image: "orange", name: "Kukulaku", email: "xz@gmail.com"))
}

struct WebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }
    func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }
}
