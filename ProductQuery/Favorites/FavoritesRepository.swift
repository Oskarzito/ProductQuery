//
//  FavoritesRepository.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-04.
//

import Foundation

class FavoritesRepository {
    
    private let persistedFavorites = BoolUserDefaults.shared
    
    func setFavorite(for key: String, value: Bool) {
        persistedFavorites.setBool(value: value, forKey: key)
    }
    
    func isFavorite(for key: String) -> Bool {
        return persistedFavorites.bool(forKey: key)
    }
}

class BoolUserDefaults {
    private let userDefaults: UserDefaults = .standard
    
    static let shared = BoolUserDefaults()
    
    private init () {}
    
    func setBool(value: Bool, forKey key: String) {
        userDefaults.set(value, forKey: String(key))
    }
    
    func bool(forKey key: String) -> Bool {
        return userDefaults.bool(forKey: String(key))
    }
    
    func removeValue(forKey key: String) {
        userDefaults.removeObject(forKey: String(key))
    }
}
