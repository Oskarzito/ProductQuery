//
//  Product.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-03.
//

import UIKit

class Product: Identifiable {
    var id: String
    let imageUrls: [String]
    let productName: String
    let price: String
    
    var images: [UIImage] = []
    
    init(from apiProduct: ProductListElement) {
        self.id = apiProduct.id!
        self.imageUrls = apiProduct.images!.compactMap { $0.url }
        self.productName = apiProduct.productName!
        self.price = apiProduct.prices!.first!.formattedPrice!
    }
    
    fileprivate init() {
        let id = UUID().uuidString
        let imageUrls: [String] = [
            "https://image.hm.com/assets/hm/94/b8/94b82939b6cfeed392c152cf86d9c63e9980959c.jpg",
            "https://image.hm.com/assets/hm/0a/9e/0a9eac7ac37cb054c8e4c57a073aa38ef4dca292.jpg",
            "https://image.hm.com/assets/hm/30/90/3090540546d00efd680d142db1524e7ecb5aa0b4.jpg",
            "https://image.hm.com/assets/hm/0e/98/0e98118d545802f4f36f2206673262abf40fc771.jpg"
        ]
        let productName: String = "Product"
        let price: String = "100.00 kr"
        
        self.id = id
        self.imageUrls = imageUrls
        self.productName = productName
        self.price = price
        
    }
}

extension Product {
    
    // MARK: - Debug
    static func mock() -> Product {
        return Product()
    }
}
