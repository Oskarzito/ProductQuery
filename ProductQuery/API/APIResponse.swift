//
//  APIResponse.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-03.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let requestDateTime: String
    let responseSource: String
    let pagination: Pagination
    let searchMeta: SearchMeta
    let searchHits: SearchHits
    let secondaryList: SecondaryList
}

// MARK: - Pagination
struct Pagination: Codable {
    let currentPage: Int
    let nextPageNum: Int
    let totalPages: Int
}

// MARK: - SearchMeta
struct SearchMeta: Codable {
    let query: String
    let didYouMean: [String]
    let relatedSearches: [String]
    let blocked: Bool
}

// MARK: - SearchHits
struct SearchHits: Codable {
    let productList: [ProductListElement]
    let contentList: [String]
    //    let sortOptions: [SortOptions]?
    let numberOfHits: Int
    //    let searchDepartments: [String]
    let sliceRanges: [String]
    //    let facets: [String]
}

// MARK: - SortOptions
struct SortOptions: Codable {
    let selected: String?
    let options: [Options]?
}

// MARK: - Options
struct Options: Codable {
    let id: String?
    let label: String?
}

// MARK: - ProductListElement
struct ProductListElement: Codable, Identifiable {
    let id: String?
    let trackingId: String?
    let productName: String?
    let external: Bool?
    let brandName: String?
    let url: String?
    let showPriceMarker: Bool?
    let prices: [PriceElement]?
    let availability: Availability?
    let swatches: [Swatch]?
    let productMarkers: [String]?
    let images: [ApiImage]?
    let hasVideo: Bool?
    let colorName: String?
    let isPreShopping: Bool?
    let isOnline: Bool?
    let modelImage: String?
    let colors: String?
    let colourShades: String?
    let productImage: String?
    let newArrival: Bool?
    let isLiquidPixelUrl: Bool?
    let colorWithNames: String?
    let mainCatCode: String?
    let sellingAttribute: String?
}

// MARK: - Availability
struct Availability: Codable {
    let stockState: String?
    let comingSoon: Bool?
}

// MARK: - Image
struct ApiImage: Codable {
    let url: String?
}

// MARK: - PriceElement
struct PriceElement: Codable {
    let priceType: String?
    let price: Int?
    let minPrice: Int?
    let maxPrice: Int?
    let formattedPrice: String?
}

// MARK: - Swatch
struct Swatch: Codable {
    let articleId: String?
    let url: String?
    let colorName: String?
    let colorCode: String?
    let trackingId: String?
    let productImage: String?
}

// MARK: - SecondaryList
struct SecondaryList: Codable {
    let productList: [String]
    let numberOfHits: Int
    let viewAllSecondaryLink: String?
}
