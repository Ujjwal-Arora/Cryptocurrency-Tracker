//
//  CoinDetailView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 13/09/24.
//

import SwiftUI

struct CoinDetailView: View {
    var coin : AllCoinsModel
    var body: some View {
        VStack {
            Text(coin.id ?? "no coin in CoinDetailView")
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
