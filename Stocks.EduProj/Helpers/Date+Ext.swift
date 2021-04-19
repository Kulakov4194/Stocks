//
//  Date+Ext.swift
//  Stocks.EduProj
//
//  Created by Виктор on 23.03.2021.
//

import SwiftUI

extension Date {
    
    enum DateFormat: String {
        case short = "MMMM dd"
    }
    
    func getFormatedDate(_ format: DateFormat) -> Text {
        
        let date = Date()
        
        let dateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = format.rawValue
            return formatter
        }()
        return Text("\(date, formatter: dateFormat)")
    }
}
