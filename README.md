# ProductQuery

ProductQuery is a SwiftUI app designed to for querying and product data along with loading images.

## Features

- Queries data from:
  https://api.hm.com/search-services/v1/sv_se/search/resultpage?touchPoint=ios&query=jeans&page=1
- Displays a grid of products where each product has a TabView of images (cover image, title and price).
- Supports navigation between pages.
- Supports marking products as favorites.

## Note

- No error states have been implemented in this MVP scope. 

## Future improvements

- Reduce image quality for improved performance.
- Product details page.
- Present more data in products (e.g. swatches and colors).
- Make the query searchable (now it's hardcoded to "jeans").
