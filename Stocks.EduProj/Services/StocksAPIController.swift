//
//  StocksAPIController.swift
//  Stocks.EduProj
//
//  Created by Сергей Мирошниченко on 26.03.2021.
//

import Foundation
import Combine


protocol StocksAPIControllerProtocol: class {
    var controller: NetworkControllerProtocol { get }
    func autocomplete(_ searchText: String) -> AnyPublisher<Response, Error>
    func getQuotes(_ symbols: String) -> AnyPublisher<QuoteResponseX, Error>
    func getSpark(_ symbols: String) -> AnyPublisher<SparkResults, Error>
}

final class StocksAPIController: StocksAPIControllerProtocol {
    
    let controller: NetworkControllerProtocol
    let endPoint = EndPoint()
    
    init(controller: NetworkControllerProtocol) {
        self.controller = controller
    }
    
    func autocomplete(_ searchText: String) -> AnyPublisher<Response, Error> {
        let temp = endPoint.autoComplete(searchText)
        return controller.get(type: Response.self,
                              url: temp.url,
                              headers: temp.headers)
    }
    
    func getQuotes(_ symbols: String) -> AnyPublisher<QuoteResponseX, Error> {
        let temp = endPoint.getQuotes(symbols)
        return controller.get(type: QuoteResponseX.self,
                              url: temp.url,
                              headers: temp.headers)
    }
    
    func getSpark(_ symbols: String) -> AnyPublisher<SparkResults, Error> {
        let temp = endPoint.getSpark(symbols)
        return controller.get(type: SparkResults.self,
                              url: temp.url,
                              headers: temp.headers)
    }
}
