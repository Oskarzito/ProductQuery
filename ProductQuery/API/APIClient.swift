//
//  APIClient.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-03.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidData
    case decodingError
}

struct APIClient {
    
    private let url: String = "https://api.hm.com"
    private let endpoint: String = "/search-services/v1/sv_se/search/resultpage" //?query=jeans&page=1
    
    static let shared = APIClient()
    
    private init() {}
    
    func request<T: Codable>(parameters: [String: String] = [:]) async throws -> T {
        guard var urlComponents = URLComponents(string: url + endpoint) else {
            throw APIError.invalidURL
        }
        
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "touchPoint", value: "ios"))

        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("HTTP Error: \(httpResponse.description)")
            throw APIError.requestFailed
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error: \(error)") // For debugging
            throw APIError.decodingError
        }
    }
}
