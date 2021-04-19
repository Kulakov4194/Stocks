//
//  QoutesEndPoints.swift
//  Stocks.EduProj
//
//  Created by Сергей Мирошниченко on 26.03.2021.
//

import Foundation

extension EndPoint {
    
    fileprivate func makeItem(_ name: QuerySymbols,_ value: String) -> URLQueryItem {
        return URLQueryItem(name: name.rawValue, value: value)
    }
    
    func autoComplete(_ searchText: String) -> Self {
        return EndPoint(queryItems: [makeItem(.q, searchText),
                                     makeItem(.region, "US")],
                        path: EndPoints.autocomplete.rawValue)
    }
    
    func getQuotes(_ symbols: String) -> Self {
        return EndPoint(queryItems: [makeItem(.symbols, symbols),
                                     makeItem(.region, "US")],
                        path: EndPoints.getQuotes.rawValue)
    }
    
    func getSpark(_ symbols: String) -> Self {
        return EndPoint(queryItems: [makeItem(.symbols, symbols),
                                     makeItem(.interval, Interval.oneMinute.rawValue),
                                     makeItem(.range, Range.oneDay.rawValue)],
                        path: EndPoints.getSpark.rawValue)
    }
}

enum Interval: String {
    case oneMinute = "1m"
    case fiveMinutes = "5m"
    case fifteenDays = "15m"
    case oneDay = "1d"
    case oneWeek = "1wk"
    case oneMonth = "1mo"
}

enum Range: String {
    case oneDay = "1d"
    case fiveDays = "5d"
    case threeMonths = "3mo"
    case sixMonts = "6mo"
    case oneYear = "1y"
    case fiveYears = "5y"
    case max = "max"
}
