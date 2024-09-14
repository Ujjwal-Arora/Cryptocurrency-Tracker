//
//  HomeView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 12/09/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedCoin : AllCoinsModel?
    @State private var quantityText = ""
    var currentValue : Double? {
        return (Double(quantityText) ?? 0) * (selectedCoin?.currentPrice ?? 0)
    }
    
    var holdingsValueSum: Double {
        return portfolioCoins.reduce(0) { partialSum, coin in
            partialSum + coin.holdingsValue
        }
    }
    
    var holdingsValuePercentageChange: Double {
        let previousTotalValue = portfolioCoins.reduce(0) { partialSum, coin in
            let percentageChangeInDecimal = (coin.priceChangePercentage24H  ?? 0) / 100
            let previousValue = coin.holdingsValue / (1 + percentageChangeInDecimal)
            return partialSum + previousValue
        }
        let percentageChange = ((holdingsValueSum - previousTotalValue) / previousTotalValue) * 100
        return percentageChange
    }
    
    @State private var allCoins = [AllCoinsModel]()
    @State private var searchText = ""
    @State private var showEditPortfolioView = false
    @State private var showPortfolio = false
    
    var sortedAndFilteredAllCoins : [AllCoinsModel]{
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
        switch sorting {
        case  .marketCapRankDescending:
            return filteredAllCoins.sorted {$0.marketCapRank ?? 0 > $1.marketCapRank ?? 0 }
        case  .marketCapRankAscending:
            return filteredAllCoins.sorted {$0.marketCapRank ?? 0 < $1.marketCapRank ?? 0 }
        case  .holdingsValueDescending:
            return filteredAllCoins.sorted {$0.holdingsValue > $1.holdingsValue }
        case  .holdingsValueAscending:
            return filteredAllCoins.sorted {$0.holdingsValue < $1.holdingsValue }
        case  .priceDescending:
            return filteredAllCoins.sorted {$0.currentPrice ?? 0 > $1.currentPrice ?? 0 }
        case  .priceAscending:
            return filteredAllCoins.sorted {$0.currentPrice ?? 0 < $1.currentPrice ?? 0 }
        }
    }
    
    @State private var sorting : SortOptions = SortOptions.priceAscending
    var portfolioCoins : [AllCoinsModel] {
        return sortedAndFilteredAllCoins.filter { coin in
            coin.holdingsValue != 0
        }
    }
    enum SortOptions {
        case marketCapRankAscending, marketCapRankDescending, holdingsValueAscending, holdingsValueDescending, priceAscending, priceDescending
    }
    
    
    var body: some View {
        VStack {
            Button("holdingsValueAscending usdt,eth,btc") {
                sorting = .holdingsValueAscending
            }
            Button("holdingsValueDescending btc,eth,usdt ") {
                sorting = .holdingsValueDescending
            }
            Button("priceAscending usdt,eth,btc") {
                sorting = .priceAscending
            }
            Button("priceDescending btc,eth,usdt") {
                sorting = .priceDescending
            }
            Button("marketCapRankAscending btc,eth,usdt") {
                sorting = .marketCapRankAscending
            }
            Button("marketCapRankDescending usdt,eth,btc") {
                sorting = .marketCapRankDescending
            }
            List {
                Button("btc 1 quanity") {
                    allCoins[0].holdingsQuantity = 1
                }
                Button("eth 2 quanity") {
                    allCoins[1].holdingsQuantity = 2
                }
                Button("usdt 3 quanity") {
                    allCoins[2].holdingsQuantity = 3
                }
                Text(holdingsValueSum.formatted())
                
                Text(sortedAndFilteredAllCoins.first?.symbol ?? "No coin available")
                
                ForEach(showPortfolio ? portfolioCoins : sortedAndFilteredAllCoins) { coin in
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
                        
                        
                        
                        if showPortfolio{
                            VStack(alignment : .leading){
                                Text(coin.holdingsValue.formatted(.currency(code: "inr")))
                                    .bold()
                                Text(coin.holdingsQuantity?.formatted() ?? "")
                            }
                        }
                        
                        
                        
                        
                        VStack(alignment : .leading){
                            Text(coin.currentPrice?.formatted(.currency(code: "inr").precision(.fractionLength(2...8))) ?? "")
                                .bold()
                            Text((coin.priceChangePercentage24H?.formatted(.number.precision(.fractionLength(2))) ?? "0") + "%")
                                .foregroundStyle(
                                    coin.priceChangePercentage24H ?? 0 >= 0 ? Color.green : Color.red
                                )
                        }
                    }
                }.font(.caption)
                
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
                    
                }.opacity(Double(quantityText) ?? 0 > 0 ? 1 : 0)
                ScrollView(.horizontal) {
                    LazyHStack{
                        ForEach(sortedAndFilteredAllCoins) { coin in
                            Button(action: {
                                withAnimation(.easeIn) {
                                    selectedCoin = coin
                                    quantityText = ""
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
                                .keyboardType(.decimalPad) //will stop from negative value as well
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
                Button(action: {
                    withAnimation {
                        showPortfolio.toggle()
                        
                    }
                }, label: {
                    Image(systemName: showPortfolio ? "chevron.backward.circle" : "chevron.forward.circle")
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
        HomeView()
    }
}
