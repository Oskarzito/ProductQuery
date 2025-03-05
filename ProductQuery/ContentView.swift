//
//  ContentView.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ContentViewModel
    @State private var toast: Toast? = nil
    
    let columns: [GridItem] = [
        .init(.flexible(), spacing: 0),
        .init(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(model.products) { product in
                    ZStack {
                        ProductView(product: product)
                        
                        HStack {
                            Spacer()
                            VStack {
                                Button {
                                    model.toggleFavorite(for: product.id)
                                } label: {
                                    Image(
                                        systemName: model.isFavorite(id: product.id) ? "heart.fill" : "heart"
                                    )
                                    .tint(.red)
                                }
                                Spacer()
                            }
                        }
                        .padding(16)
                    }
                    .onTapGesture {
                        toast = Toast(
                            style: .success,
                            message: "To be implemented ..."
                        )
                    }
                }
            }
            
            PageNavigatorView(
                pageNavigator: model.pageNavigator,
                nextPage: {
                    Task {
                        await model.nextPage()
                    }
                },
                previousPage: {
                    Task {
                        await model.previousPage()
                    }
                }
            )
        }
        .safeAreaPadding(.vertical)
        .toastView(toast: $toast)
    }
}

#Preview {
    @Previewable @StateObject var viewModel: ContentViewModel = .init(isDebug: true)
    
    ContentView()
        .environmentObject(viewModel)
        .onAppear {
            viewModel.fetchDebugProducts()
        }
}
