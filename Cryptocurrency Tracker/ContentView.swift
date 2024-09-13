//
//  ContentView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 12/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var allCoins = [AllCoinsModel]()
    @State private var searchText = ""
    @State private var showEditPortfolioView = false
    
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
                
                
                
                ForEach(filteredAllCoins) { coin in
                    NavigationLink(value: coin) {
                        
                        HStack{
                            Text(coin.marketCapRank?.formatted() ?? "")
                                .bold()
                                .font(.caption)
                                .frame(minWidth: 30)
                            AsyncImage(url: URL(string: coin.image ?? ""),scale: 10)
                            Text(coin.symbol?.uppercased() ?? "")
                                .font(.headline)
                                .padding(.leading,5)
                        }
                        //                    VStack(alignment : .leading){
                        //                        Text("\(coin.currentHoldingsValue.formatted(.currency(code: "inr")))")
                        //                            .bold()
                        //                        Text("\(coin.currentHoldings?.formatted(.number.precision(.fractionLength(2...8))) ?? "0")")
                        //                    }
                        VStack(alignment : .leading){
                            Text(coin.currentPrice?.formatted(.currency(code: "inr").precision(.fractionLength(2...8))) ?? "")
                                .bold()
                            Text((coin.priceChangePercentage24H?.formatted(.number.precision(.fractionLength(2))) ?? "0") + "%")
                                .foregroundStyle(
                                    coin.priceChangePercentage24H ?? 0 >= 0 ? Color.green : Color.red
                                )
                        }
                    }
                }
                
            }.listStyle(.plain)
                .navigationDestination(for: AllCoinsModel.self) { coin in
                    CoinChartView(coin: coin)
                }
        }.sheet(isPresented: $showEditPortfolioView, content: {
           // EditPortfolioView()
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
