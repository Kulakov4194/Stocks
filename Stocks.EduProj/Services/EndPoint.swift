//
//  EndPoint.swift
//  Stocks.EduProj
//
//  Created by Сергей Мирошниченко on 26.03.2021.
//

import Foundation

typealias HTTPHeaders = [String : Any]

protocol EndPointProtocol {
    var queryItems: [URLQueryItem] { get }
    var url: URL { get }
    var headers: HTTPHeaders { get }
    var path: String { get }
}

struct EndPoint {
    var queryItems: [URLQueryItem] = []
    var path: String = ""
}

extension EndPoint: EndPointProtocol {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "apidojo-yahoo-finance-v1.p.rapidapi.com"
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        print(url)
        return url
    }
    
    var headers: HTTPHeaders {
        return ["x-rapidapi-key": "a0017eaaedmshfd55baf692ef617p111fdejsna896695148dd",
                "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com"]
    }
}
