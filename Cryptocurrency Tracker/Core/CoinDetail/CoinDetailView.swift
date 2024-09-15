//
//  CoinDetailView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 13/09/24.
//

import SwiftUI

struct CoinDetailView: View {
    var coin : CoinModel
    var body: some View {
        ScrollView {
            Text(coin.id ?? "no coin in CoinDetailView")
            CoinChartView(coin: coin)
            
            StatsView(title: "Total holdings value", 
                      value: coin.holdingsValue.currencyFormatter()
            )
            
            StatsView(title: "Market Cap (24hr)", 
                      value: coin.marketCap?.currencyFormatter() ?? "",
                      percentageChange: coin.marketCapChangePercentage24H
            )
            
            StatsView(title: "Current Price (24hr)", 
                      value: coin.currentPrice?.formatted(.currency(code: "inr")) ?? "",
                      percentageChange: coin.priceChangePercentage24H
            )
            
            StatsView(title: "Volume", 
                      value: coin.totalVolume?.formatted() ?? ""
            )
            
        }.navigationTitle(coin.name ?? "no name")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    HStack{
                        AsyncImage(url: URL(string: coin.image ?? ""),scale: 10)
                        Text(coin.symbol?.uppercased() ?? "")
                    }
                }
            }
    }
}

#Preview {
    NavigationStack{
        CoinDetailView(coin: Example().coin)
    }
}
