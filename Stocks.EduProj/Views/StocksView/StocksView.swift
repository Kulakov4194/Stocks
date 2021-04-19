//
//  StocksView.swift
//  Stocks.EduProj
//
//  Created by Виктор on 20.03.2021.
//

import SwiftUI

struct StocksView: View {
    @ObservedObject var viewModel = StocksListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    VStack {
                        List {
                            ForEach(viewModel.watchListItems, id: \.symbol) { quote in
                                StocksCell(model: quote)
                            }
                            .onDelete (perform: {
                                viewModel.deleteFromWatchList(at: $0)
                            })
                        }
                        .listStyle(PlainListStyle())
                        .onAppear {
                            UITableView.appearance().backgroundColor = .black
                        }
                    }
                    .padding(.top, 4)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: NavigationTitle(), trailing: EditButton())
                    .navigationBarSearch($viewModel.searchTerm, cancelClicked: {
                        viewModel.fetchWatchList()
                    }, resultContent: { _ in 
                        List {
                            ForEach(viewModel.results, id: \.symbol) { quote in
                                //StocksCell(model: quote, spark: <#T##SymbolSpark#>)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .onAppear {
                            UITableView.appearance().backgroundColor = .black
                        }
                    } )
                }
                TabBarView()
            }
        }
    }
    
    struct StocksView_Previews: PreviewProvider {
        static var previews: some View {
            StocksView()
                .preferredColorScheme(.dark)
        }
    }
}

struct NavigationTitle: View {
    
    let date = Date()
    
    var body: some View {
        VStack(alignment: .leading, spacing: -8) {
            Text("Stocks")
                .font(.system(size:26))
                .fontWeight(.heavy)
                .kerning(0.20)
                .foregroundColor(.white)
            date.getFormatedDate(.short)
                .font(.system(size: 26))
                .fontWeight(.heavy)
                .kerning(0.20)
                .foregroundColor(Color(#colorLiteral(red: 0.631372549, green: 0.6470588235, blue: 0.662745098, alpha: 1)))
        }
        .background(Color(.clear))
        .padding(.all, 4)
    }
}

struct LeftTabBarButton: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Image("yahooLogo").renderingMode(.template).foregroundColor(.gray)
        })
    }
}


struct TabBarView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack {
                LeftTabBarButton()
                    .padding()
                    .frame(width: geometry.size.width / 2, alignment: .leading)
                    .accentColor(.blue)
                
                Button(action: {}, label: {
                    Text("Button").foregroundColor(.white)
                }).padding()
                .frame(width: geometry.size.width / 2, alignment: .trailing)
            }
        }.frame(height: 50)
        .background(Color.init(#colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1))
                        .ignoresSafeArea())
    }
}
