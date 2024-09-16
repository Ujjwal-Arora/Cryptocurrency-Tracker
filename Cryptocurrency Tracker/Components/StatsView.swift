//
//  StatsView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 12/09/24.
//

import SwiftUI

struct StatsView: View {
    let title : String
    let value : String
    var percentageChange : Double?

    var body: some View {
            VStack(spacing: 5){
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.gray)
                Text(value)
                    .font(.footnote)
                    .bold()
                HStack(spacing : 5){
                    Image(systemName: percentageChange ?? 0 >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    Text(percentageChange?.percentageFormatter() ?? "")
                }
                .font(.footnote)
                .foregroundStyle(percentageChange ?? 0 >= 0 ? Color.green : Color.red)
                .opacity(percentageChange == nil ? 0 : 1)
            }.frame(maxWidth: .infinity)
            .padding(7)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                    .foregroundStyle(.gray)
            }
            .padding(0)

        
        
            
    }
}
//
//#Preview {
//    NavigationStack{
//        CoinDetailView(coin: MockData.exampleCoin)
//    }
//}

#Preview {
    NavigationStack{
        StatsView(title: "Market Cap", value: "2100", percentageChange: 7.25)
//        StatsView(title: "Market Cap (24hr)",
//                  value: MockData.exampleCoin.marketCap?.currencyFormatter() ?? "",
//                  percentageChange: MockData.exampleCoin.marketCapChangePercentage24H
//        )
    }
}
