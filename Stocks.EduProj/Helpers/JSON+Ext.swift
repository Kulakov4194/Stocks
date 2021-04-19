//
//  JSON+Ext.swift
//  Stocks.EduProj
//
//  Created by Виктор on 25.03.2021.
//

import SwiftyJSON


protocol JSONable: class {
    init?(json: JSON)
}

extension JSON {
    func to<T>(type: T?) -> Any? {
            if let baseObj = type as? JSONable.Type {
                if self.type == .array {
                    var arrObject: [Any] = []
                    for obj in self.arrayValue {
                        let object = baseObj.init(json: obj)
                        arrObject.append(object!)
                    }
                    return arrObject
                } else {
                    let object = baseObj.init(json: self)
                    return object!
                }
            }
            return nil
        }
}
