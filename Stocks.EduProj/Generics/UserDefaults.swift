//
//  UserDefaults.swift
//  Stocks.EduProj
//
//  Created by Виктор on 29.03.2021.
//

import Foundation


public enum Keys: String {
    case watchlist = "Watchlist"
}

@propertyWrapper
struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T
    init(key: Keys, defaultValue: T) {
        self.key = key.rawValue
        self.defaultValue = defaultValue
    }
    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }
            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)
            
            // Set value to UserDefaults
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

