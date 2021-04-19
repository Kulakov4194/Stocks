//
//  Spark.swift
//  Stocks.EduProj
//
//  Created by Виктор on 30.03.2021.
//

import Foundation

typealias SparkResults = [String : SymbolSpark]

struct SymbolSpark: Codable {
    var symbol: String?
    var end: Int?
    var start: Int?
    var timestamp: [Int]?

    var previousClose: Double?
    var chartPreviousClose: Double?
    var close: [Double]?
    
    static var prototype: SymbolSpark {
        return SymbolSpark(symbol: "", end: 0, start: 0, timestamp: [], previousClose: 0, chartPreviousClose: 0, close: [])
    }
}
