//
//  StockCell.swift
//  Stocks.EduProj
//
//  Created by Виктор on 07.04.2021.
//

import SwiftUI
import Charts

protocol StockCellViewModel {
    var shortname: String { get }
    var longname: String { get }
    var regMarketPrice: Double { get }
    var regMarketChange: Double { get }
    var symb: String { get }
    var sparkModel: SymbolSpark { get set }
}

struct StocksCell: View  {
    var model: Result
    var body: some View {
        
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text(model.symb)
                    .padding(.all, 4)
                    .foregroundColor(.white)
                Text(model.shortname)
                    .padding(.all, 4)
                    .foregroundColor(.gray)
            }
            Chart(data: model.sparkModel.close ?? [])
                .chartStyle(
                        LineChartStyle(.line, lineColor: .green, lineWidth: 1)
                    )
                .padding()
            VStack(alignment: .trailing) {
                Text(String(format: "%.2f", model.regMarketPrice))
                    .padding(.leading, 4)
                    .foregroundColor(.white)
                Button (action: {
                    print("\(model.description)")
                }, label: {
                    Text(String(format: "%.2f", model.regMarketChange))
                        .padding(.all, 4)
                        .background(model.regMarketChange >= 0 ? Color.green : .red)
                        .cornerRadius(4)
                        .foregroundColor(.white)
                })
            }
            .listRowBackground(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
        }
        
    }
}
