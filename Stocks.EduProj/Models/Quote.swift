//
//  Stocks.swift
//  Stocks.EduProj
//
//  Created by Виктор on 19.03.2021.
//

import Foundation

// MARK: - Debugging Helper
extension CustomStringConvertible where Self: Decodable {
    var description: String {
        var description = "\n***** \(type(of: self)) *****\n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}

struct Response: Decodable, CustomStringConvertible {
    var quotes: [Quote]?
}

struct Quote: Decodable, CustomStringConvertible {
    var shortname: String?
    var symbol: String?
}
