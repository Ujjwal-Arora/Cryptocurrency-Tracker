//
//  RowView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 14/09/24.
//

import SwiftUI
struct RowView: View {
    let coin : CoinModel
    let showHoldingsColumn : Bool
    var body: some View {
        GeometryReader(content: { fullView in
            HStack{
                leftColumn
                

                Spacer()
                
                if showHoldingsColumn{
                    centreColumn
                        .frame(width: fullView.size.width/3,alignment: .leading)
                }
                rightColumn
                    .frame(width: fullView.size.width/3,alignment: .leading)
            }
            .font(.subheadline)
            .padding(.bottom)
        })
        
    }
}

#Preview {
    RowView(coin : Example().coin, showHoldingsColumn: true)
}

extension RowView {
    private var leftColumn : some View{
        HStack(alignment : .top){
            Text(coin.marketCapRank?.formatted() ?? "")
                .bold()
                .font(.caption)
                .frame(minWidth: 20)
            AsyncImage(url: URL(string: coin.image ?? ""),scale: 10)

            Text(coin.symbol?.uppercased() ?? "")
                .font(.headline)
        }
        
    }
    private var centreColumn : some View {
        VStack(alignment : .leading){
            Text(coin.holdingsValue.currencyFormatter())
                .bold()
            Text(coin.holdingsQuantity?.quantityFormatter() ?? "")
        }
    }
    private var rightColumn : some View {
        VStack(alignment : .leading){
            Text(coin.currentPrice?.currencyFormatter() ?? "")
                .bold()
            Text(coin.priceChangePercentage24H?.percentageFormatter() ?? "")
                .foregroundStyle(
                    coin.priceChangePercentage24H ?? 0 >= 0 ? Color.green : Color.red
                )
        }
    }
}
