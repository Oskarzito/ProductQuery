//
//  ProductQueryTests.swift
//  ProductQueryTests
//
//  Created by Oskar Emilsson on 2025-03-03.
//

import Testing
@testable import ProductQuery
import Combine
import UIKit

@Suite class ImageCacheViewModelTests {

    var viewModel: ImageCacheViewModel!

    init() throws {
        viewModel = ImageCacheViewModel()
    }

    deinit {
        viewModel = nil
    }

    @Test func testLoadImage_NilURL() {
        viewModel.loadImage(url: nil)
        #expect(viewModel.images.isEmpty)
        #expect(viewModel.isLoading.isEmpty)
        #expect(viewModel.error.isEmpty)
    }

    @Test func testLoadImage_CachedImage() {
        let url = URL(string: "https://example.com/image.jpg")!
        let image = UIImage() // Mock image

        viewModel.images[url] = image

        viewModel.loadImage(url: url)

        #expect(viewModel.images[url] == image)
        #expect(viewModel.isLoading[url] == nil)
        #expect(viewModel.error[url] == nil)
    }

    func testLoadImage_AlreadyLoading() {
        let url = URL(string: "https://example.com/image.jpg")!
        viewModel.isLoading[url] = true

        viewModel.loadImage(url: url)

        #expect(viewModel.isLoading[url]!)
    }
}
