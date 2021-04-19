//
//  QuoteResponse.swift
//  Stocks.EduProj
//
//  Created by Виктор on 26.03.2021.
//

import Foundation


struct QuoteResponseX: Decodable, CustomStringConvertible {
    var quoteResponse: QuoteResponse?
}

struct QuoteResponse: Decodable, CustomStringConvertible {
    var result: [Result]?
    
    func getSymbols() -> [String] {
        return result?.compactMap { $0.symbol } ?? []
    }
}

struct Result: Codable, CustomStringConvertible {
    
    var shortName: String?
    var longName: String?
    var regularMarketPrice: Double?
    var regularMarketChange: Double?
    var symbol: String?
    
    private enum CodingKeys: String, CodingKey {
        case shortName, longName, regularMarketPrice, regularMarketChange, symbol
    }
    
    var sparkModel: SymbolSpark = SymbolSpark.prototype
}

extension Result: StockCellViewModel {
    
    var shortname: String {
        return shortName ?? ""
    }
    
    var longname: String {
        return longName ?? ""
    }
    
    var regMarketPrice: Double {
        return regularMarketPrice ?? 0
    }
    
    var regMarketChange: Double {
        return regularMarketChange ?? 0
    }
    
    var symb: String {
        return symbol ?? ""
    }
}
