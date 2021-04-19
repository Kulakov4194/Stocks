//
//  AppData.swift
//  Stocks.EduProj
//
//  Created by Виктор on 29.03.2021.
//

struct AppData {
    @Storage(key: Keys.watchlist, defaultValue: ["AAPL", "GOOG", "YHOO"])
    
    static var watchlist: [String]
    static func getSymbols() -> String {
        return watchlist.joined(separator: ",")
    }
}

