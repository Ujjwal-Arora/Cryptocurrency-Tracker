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
            
            CoinChartView(coin: coin)
                .padding(.vertical)
            
            VStack {
                HStack {
                    StatsView(title: "Market Cap (24hr)",
                              value: coin.marketCap?.currencyFormatter() ?? "",
                              percentageChange: coin.marketCapChangePercentage24H
                    )
                    StatsView(title: "Current Price (24hr)",
                              value: coin.currentPrice?.formatted(.currency(code: "inr")) ?? "",
                              percentageChange: coin.priceChangePercentage24H
                    )
                }
                
                
                HStack{
                    StatsView(title: "Current holdings",
                              value: coin.holdingsValue.currencyFormatter()
                    )
                    Spacer()
                    StatsView(title: "Volume",
                              value: coin.totalVolume?.formatted() ?? ""
                    )
                }
                
            }
            
        }
        .navigationTitle(coin.name ?? "no name")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                HStack{
                    CoinImageView(imageUrlSting: coin.image ?? "", imageSize: .small)

                    Text(coin.symbol?.uppercased() ?? "")
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        CoinDetailView(coin: MockData.exampleCoin)
    }
}
