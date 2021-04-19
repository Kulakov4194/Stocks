//
//  Dictionary+Ext.swift
//  Stocks.EduProj
//
//  Created by Виктор on 26.03.2021.
//

import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
