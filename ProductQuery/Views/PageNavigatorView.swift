//
//  PageNavigatorView.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-05.
//

import SwiftUI

struct PageNavigatorView: View {
    let pageNavigator: ContentViewModel.PageNavigator
    let nextPage: () -> Void
    let previousPage: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                previousPage()
            }) {
                Image(systemName: "chevron.left")
                    .padding()
            }
            .disabled(pageNavigator.currentPage == 1)
            
            Text("Page \(pageNavigator.currentPage) of \(pageNavigator.totalPages)")
                .padding()
            
            Button(action: {
                nextPage()
            }) {
                Image(systemName: "chevron.right")
                    .padding()
            }
            .disabled(pageNavigator.currentPage == pageNavigator.totalPages)
        }
    }
}

struct PageNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        PageNavigatorView(
            pageNavigator: .init(
                currentPage: 5,
                nextPageNum: 6,
                previousPageNum: 4,
                totalPages: 43
            ),
            nextPage: {},
            previousPage: {}
        )
        .previewLayout(.sizeThatFits)
    }
}
