//
//  CachedAsyncImage.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-04.
//

import Combine
import SwiftUI

struct CachedAsyncImage<Content: View>: View {
    @StateObject private var imageCache = ImageCacheViewModel()
    let url: URL?
    @Binding var tab: Int
    @ViewBuilder let content: (Image?) -> Content
    
    var body: some View {
        ZStack {
            content(
                url.flatMap { imageCache.images[$0] }
                    .map { Image(uiImage: $0) }
            )
        }
        .onAppear {
            imageCache.loadImage(url: url)
        }
    }
}

class ImageCacheViewModel: ObservableObject {
    @Published var images: [URL: UIImage] = [:]
    @Published var isLoading: [URL: Bool] = [:]
    @Published var error: [URL: Error?] = [:]
    
    private var cancellables: [URL: AnyCancellable] = [:]
    
    func loadImage(url: URL?) {
        guard let url = url else { return }
        
        if images[url] != nil {
            return
        }
        
        if isLoading[url] == true {
            return
        }
        
        isLoading[url] = true
        
        cancellables[url] = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                if let image = image {
                    self?.images[url] = image
                } else {
                    self?.error[url] = URLError(.cannotDecodeContentData)
                }
                
                self?.isLoading[url] = false
            }
    }
}
