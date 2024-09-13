//
//  ContentView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 12/09/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedCoin : AllCoinsModel?
    @State private var quantityText = ""
    var currentValue : Double? {
        return (Double(quantityText) ?? 0) * (selectedCoin?.currentPrice ?? 0)
    }
    
    @State private var allCoins = [AllCoinsModel]()
    @State private var searchText = ""
    @State private var showEditPortfolioView = true
    
    var filteredAllCoins : [AllCoinsModel]{
        if searchText.isEmpty {
            return allCoins
        }else {
            return allCoins.filter { coin in
                (coin.name?.lowercased() ?? "").contains(searchText.lowercased()) ||
                (coin.id?.lowercased() ?? "").contains(searchText.lowercased()) ||
                (coin.symbol?.lowercased() ?? "").contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            
            List {
                Text(filteredAllCoins.first?.symbol ?? "No coin available")
                
                
                
                //                ForEach(filteredAllCoins) { coin in
                //                    NavigationLink(value: coin) {
                //
                //                        HStack{
                //                            Text(coin.marketCapRank?.formatted() ?? "")
                //                                .bold()
                //                                .font(.caption)
                //                                .frame(minWidth: 30)
                //                            AsyncImage(url: URL(string: coin.image ?? ""),scale: 10)
                //                            Text(coin.symbol?.uppercased() ?? "")
                //                                .font(.headline)
                //                                .padding(.leading,5)
                //                        }
                //                        //                    VStack(alignment : .leading){
                //                        //                        Text("\(coin.currentHoldingsValue.formatted(.currency(code: "inr")))")
                //                        //                            .bold()
                //                        //                        Text("\(coin.currentHoldings?.formatted(.number.precision(.fractionLength(2...8))) ?? "0")")
                //                        //                    }
                //                        VStack(alignment : .leading){
                //                            Text(coin.currentPrice?.formatted(.currency(code: "inr").precision(.fractionLength(2...8))) ?? "")
                //                                .bold()
                //                            Text((coin.priceChangePercentage24H?.formatted(.number.precision(.fractionLength(2))) ?? "0") + "%")
                //                                .foregroundStyle(
                //                                    coin.priceChangePercentage24H ?? 0 >= 0 ? Color.green : Color.red
                //                                )
                //                        }
                //                    }
                //                }
                
            }.listStyle(.plain)
                .navigationDestination(for: AllCoinsModel.self) { coin in
                    CoinChartView(coin: coin)
                }
        }
        .fullScreenCover(isPresented: $showEditPortfolioView, content: {
            
            // EditPortfolioView()
            VStack{
                Button("save") {
                    if let selectedCoin = selectedCoin, let index = allCoins.firstIndex(where: {$0.id == selectedCoin.id}){
                        allCoins[index].holdingsQuantity = Double(quantityText)
                    }
                    quantityText = ""
                    selectedCoin = nil
                    showEditPortfolioView = false

                }
                ScrollView(.horizontal) {
                    LazyHStack{
                        ForEach(filteredAllCoins) { coin in
                            Button(action: {
                                withAnimation(.easeIn) {
                                    selectedCoin = coin
                                    
                                }
                            }, label: {
                                VStack{
                                    AsyncImage(url: URL(string: coin.image ?? ""), scale: 5)
                                    Text(coin.symbol?.uppercased() ?? "")
                                        .font(.headline)
                                    
                                    Text(coin.name ?? "")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .multilineTextAlignment(.center)
                                    
                                }
                                .foregroundStyle(.black)
                                .frame(width: 70, height: 90)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .stroke(coin == selectedCoin ? Color.green : Color.gray)
                                )
                                
                            })
                            
                        }
                    }
                }
                VStack{
                    if let item = selectedCoin{
                        
                        HStack{
                            Text("Current Price of \(item.symbol?.uppercased() ?? "") :")
                            Spacer()
                            Text(item.currentPrice?.formatted(.currency(code: "inr")) ?? "")
                        }
                        Divider()
                        HStack{
                            Text("Current holdings quantity :")
                            TextField(item.holdingsQuantity?.formatted() ?? "0.0", text: $quantityText)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                        Divider()
                        HStack{
                            Text("Current holdings value :")
                            Spacer()
                            Text((quantityText.isEmpty ? item.holdingsValue.formatted() : currentValue?.formatted()) ?? "" )
                            
                        }
                        
                    }
                }
                .padding()
                .font(.headline)
            }
        })
        .navigationTitle(showEditPortfolioView ? "Portfolio Prices" : "Live Prices" )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    showEditPortfolioView = true
                }, label: {
                    Image(systemName: "plus.circle")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Image(systemName: showEditPortfolioView ? "chevron.backward.circle" : "chevron.forward.circle")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                })
            }
        }
        .searchable(text: $searchText)
        .task {
            do {
                allCoins = try await fetchAllCoins()
            } catch {
                print("Failed to fetch all coins \(error.localizedDescription)")
            }
        }
        
    }
    
    
    func fetchAllCoins() async throws -> [AllCoinsModel]{
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&sparkline=true&price_change_percentage=24h") else {
            throw URLError(.badURL) }
        let (data,_) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([AllCoinsModel].self, from: data)
    }
}


#Preview {
    NavigationStack{
        ContentView()
    }
}
