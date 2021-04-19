//
//  EndPoints+QueryParams.swift
//  Stocks.EduProj
//
//  Created by Сергей Мирошниченко on 26.03.2021.
//

enum QuerySymbols: String {
    case q = "q"
    case region = "region"
    case symbols = "symbols"
    case interval = "interval"
    case range = "range"
}

enum EndPoints: String {
    case autocomplete = "/auto-complete"
    case getQuotes = "/market/v2/get-quotes"
    case getSpark = "/market/get-spark"
}
