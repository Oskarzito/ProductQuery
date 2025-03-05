//
//  ContentViewModel.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-03.
//

import UIKit

class ContentViewModel: ObservableObject {
    private let isDebug: Bool
    private let favoritesRepository = FavoritesRepository()
    
    struct PageNavigator {
        let currentPage: Int
        let nextPageNum: Int
        let previousPageNum: Int
        let totalPages: Int
    }

    @Published var products: [Product] = []
    @Published var query = "jeans"
    @Published var isLoading: Bool = true
    @Published var favorites: [String: Bool] = [:]
    @Published var isFirstPage: Bool = true
    @Published var pageNavigator: PageNavigator = .init(currentPage: 1, nextPageNum: 1, previousPageNum: 1, totalPages: 1)
    
    init(isDebug: Bool = false) {
        self.isDebug = isDebug
    }
    
    func fetchProducts(isNextPageAction: Bool = true) async {
        do {
            await MainActor.run {
                self.isLoading = true
            }
            let nextPageNum = isNextPageAction ? pageNavigator.nextPageNum : pageNavigator.previousPageNum
            
            // Fetch all products for page
            let response: SearchResponse = try await APIClient.shared.request(
                parameters: ["query": query, "page": "\(nextPageNum)"]
            )
            
            let products = response.searchHits.productList.map { Product(from: $0) }
            
            await MainActor.run {
                self.pageNavigator = .init(
                    currentPage: response.pagination.currentPage,
                    nextPageNum: response.pagination.nextPageNum,
                    previousPageNum: response.pagination.currentPage - 1,
                    totalPages: response.pagination.totalPages
                )
                self.products = products
                self.isLoading = false
            }
            
            
            print(response)
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func isFavorite(id: String) -> Bool {
        favorites[id] ?? false
    }
    
    func toggleFavorite(for id: String) {
        let isMarkedAsFavorite = !isFavorite(id: id)
        favoritesRepository.setFavorite(for: id, value: isMarkedAsFavorite)
        favorites[id] = isMarkedAsFavorite
    }

    func nextPage() async {
        await self.fetchProducts(isNextPageAction: true)
    }
    
    func previousPage() async {
        await self.fetchProducts(isNextPageAction: false)
    }
}

extension ContentViewModel {
    func fetchDebugProducts() {
        self.products = [Product.mock(), Product.mock(), Product.mock(), Product.mock()]
    }
}
