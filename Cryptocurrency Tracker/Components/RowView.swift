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
                        .frame(width: fullView.size.width/3.3,alignment: .leading)
                }
                rightColumn
                    .frame(width: fullView.size.width/3.6,alignment: .leading)
            }.frame(height: 35)
            
        })
        
    }
}

#Preview {
    RowView(coin : MockData.exampleCoin, showHoldingsColumn: true)
}

extension RowView {
    private var leftColumn : some View{
        HStack(alignment : .top){
            Text(coin.marketCapRank?.formatted() ?? "")
                .frame(minWidth: 20)
            CoinImageView(imageUrlSting: coin.image ?? "", imageSize: .small)

            Text(coin.symbol?.uppercased() ?? "")

        }.font(.headline)

        
    }
    private var centreColumn : some View {
            VStack(alignment : .leading,spacing: 0){
                Text(coin.holdingsValue.currencyFormatter())
                    .bold()
                Text(coin.holdingsQuantity?.quantityFormatter() ?? "")
            }.font(.subheadline)
    }
    private var rightColumn : some View {
        VStack(alignment : .leading,spacing: 0){
            Text(coin.currentPrice?.currencyFormatter() ?? "")
                .bold()
            Text(coin.priceChangePercentage24H?.percentageFormatter() ?? "")
                .foregroundStyle(
                    coin.priceChangePercentage24H ?? 0 >= 0 ? Color.green : Color.red
                )
        }.font(.subheadline)
    }
}
