//
//  ProductQueryApp.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-03.
//

import SwiftUI

@main
struct ProductQueryApp: App {
    @StateObject var contentViewModel = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if contentViewModel.isLoading {
                    ProgressView()
                    
                } else {
                    ContentView()
                        .environmentObject(contentViewModel)
                }
            }
            .task {
                await contentViewModel.fetchProducts()
            }
        }
    }
}
