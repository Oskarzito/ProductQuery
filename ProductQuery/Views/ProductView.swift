//
//  ProductView.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-03.
//

import SwiftUI

struct ProductView: View {
    
    @State private var currentPage: Int = 0
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            TabView(selection: $currentPage) {
                ForEach(0..<product.imageUrls.count, id: \.self) { index in
                    if let url = URL(string: product.imageUrls[index]) {
                        CachedAsyncImage(url: url, tab: $currentPage) { image in
                            if let image {
                                image
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                ProgressView()
                            }
                        }
                        .id(index)
                        .tag(index)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: 200, height: 300)
            
            VStack(alignment: .leading) {
                Text(product.productName)
                    .font(.title3)
                    .lineLimit(1)
                Text(product.price)
                    .font(.title3)
                    .bold()
            }
            .padding(.leading, 8)
        }
    }
}

#Preview {
    HStack {
        ProductView(product: Product.mock())
    }
}
