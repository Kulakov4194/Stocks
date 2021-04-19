//
//  ViewModel.swift
//  Stocks.EduProj
//
//  Created by Виктор on 24.03.2021.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

final class StocksListViewModel: ObservableObject {
    
    let stocksController = StocksAPIController(controller: NetworkController())
    
    @Published var quotes: [Quote] = []
    @Published private(set) var results: [Result] = []
    @Published private(set) var watchListItems: [Result] = []
    @Published var searchTerm = ""
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { (string) -> String? in
                if string.count < 1 {
                    self.results = []
                    return nil
                }
                return string
            }
            .compactMap { $0 }
            .sink { (_) in
                //
            } receiveValue: { [self] (_) in
                fetchQuotes()
            }.store(in: &subscriptions)
        fetchWatchList()
    }
    
     func fetchWatchList() {
        stocksController.getQuotes(AppData.getSymbols())
            .receive(on: RunLoop.main)
            .map { response -> AnyPublisher<SparkResults, Error> in
                self.watchListItems = response.quoteResponse?.result ?? []
                let symbols = response.quoteResponse?.result?.compactMap { $0.symbol }
                let joinedSymbols = symbols?.joined(separator: ",") ?? ""
                return self.stocksController.getSpark(joinedSymbols)
            }
            .switchToLatest()
            .receive(on: RunLoop.main)
            .sink { (comp) in
                switch comp {
                case let .failure(error):
                    print("Couldn't get sparks: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] qResponse in
                self?.watchListItems = (self?.watchListItems.compactMap { item -> Result in
                    var item = item
                    if let model = qResponse[item.symbol ?? ""] {
                        if let previousClose = model.previousClose {
                            let values = model.close?.map { (($0 - previousClose) / previousClose) * 100 }
                            var sparkModel = item.sparkModel
                            sparkModel.close = values
                            item.sparkModel = sparkModel
                        }
                    }
                    return item
                }) ?? []
            }
            .store(in: &subscriptions)
    }
    
    
    private func fetchQuotes() {
        stocksController.autocomplete(searchTerm)
            .map { response -> AnyPublisher<QuoteResponseX, Error> in
                let symbols = response.quotes?.compactMap { $0.symbol }
                let joinedSymbols = symbols?.joined(separator: ",") ?? ""
                return self.stocksController.getQuotes(joinedSymbols)
            }
            .switchToLatest()
            .receive(on: RunLoop.main)
            .sink { (comp) in
                switch comp {
                case let .failure(error):
                    print("Couldn't get quotes: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] qRespone in
                self?.results = qRespone.quoteResponse?.result ?? []
            }
            .store(in: &subscriptions)
    }
    
    func deleteFromWatchList(at offsets: IndexSet) {
        self.results.remove(atOffsets: offsets)
        AppData.watchlist = self.results.compactMap { $0.symbol }
    }
}

