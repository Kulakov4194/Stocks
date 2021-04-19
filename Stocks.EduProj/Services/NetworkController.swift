//
//  Service.swift
//  Stocks.EduProj
//
//  Created by Виктор on 26.03.2021.
//

import Foundation
import Combine
import SwiftyJSON

protocol NetworkControllerProtocol: class {
    func get<T>(type: T.Type,
                url: URL,
                headers: HTTPHeaders
    ) -> AnyPublisher<T, Error> where T: Decodable
    
    func getT<T>(type: T.Type,
                 url: URL,
                 headers: HTTPHeaders
    ) -> AnyPublisher<T, Error> where T: Decodable
}


final class NetworkController: NetworkControllerProtocol {
    
    func get<T: Decodable>(type: T.Type,
                           url: URL,
                           headers: HTTPHeaders
    ) -> AnyPublisher<T, Error> {

        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getT<T>(type: T.Type,
                 url: URL,
                 headers: HTTPHeaders
    ) -> AnyPublisher<T, Error> where T: Decodable {
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .tryMap({ (data) -> T in
                do {
                    let json = try JSON(data: data)
                    return json as! T
                } catch {
                    throw error
                }
            })
            .eraseToAnyPublisher()
    }
}
