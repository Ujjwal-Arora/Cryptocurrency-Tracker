////
////  EditPortfolioView.swift
////  Cryptocurrency Tracker
////
////  Created by Ujjwal Arora on 13/09/24.
////
//
//import SwiftUI
//
//struct EditPortfolioView: View {
//    @State private var selectedCoin = AllCoinsModel?.self
//    var body: some View {
//        ScrollView(.horizontal,showsIndicators: false) { //show indicator kya karta h
//            LazyHStack{
//                ForEach(filteredAllCoins){coin in
//                    VStack{
////                                CoinImageView(imageUrl: coin.image)
////                                    .frame(width: 50,height: 50)
//                        Text(coin.symbol.uppercased())
//                            .font(.headline)
//                            .foregroundStyle(.accent)
//                        Text(coin.name)
//                            .font(.caption)
//                            .foregroundStyle(.secondaryText)
//                            .lineLimit(2)
//                            .multilineTextAlignment(.center)
//                        
//                    }
//                        .frame(width: 70)
//                        .padding()
//                        .onTapGesture {
//                            withAnimation(.easeIn) {
//                                selectedCoin = coin
//                            }
//                        }
//                        .background(RoundedRectangle(cornerRadius: 10)
//                            .stroke(coin.id == selectedCoin?.id ? Color.theme.green : Color.theme.secondaryText,lineWidth: coin.id == selectedCoin?.id ? 3 : 1)
//                        )
//                }.padding(.leading,2)
//            }
//        }
//    }
//}
//
//#Preview {
//    EditPortfolioView()
//}
