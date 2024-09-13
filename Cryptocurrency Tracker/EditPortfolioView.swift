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
//    @State private var selectedCoin : AllCoinsModel?
//    
//    @State private var allCoins = [AllCoinsModel]()
//    @State private var searchText = ""
//    @State private var showEditPortfolioView = false
//    
//    var filteredAllCoins : [AllCoinsModel]{
//        if searchText.isEmpty {
//            return allCoins
//        }else {
//            return allCoins.filter { coin in
//                (coin.name?.lowercased() ?? "").contains(searchText.lowercased()) ||
//                (coin.id?.lowercased() ?? "").contains(searchText.lowercased()) ||
//                (coin.symbol?.lowercased() ?? "").contains(searchText.lowercased())
//            }
//        }
//    }
//
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
//        }.task {
//            do {
//                allCoins = try await fetchAllCoins()
//            } catch {
//                print("Failed to fetch all coins \(error.localizedDescription)")
//            }
//        }
//    }
//    func fetchAllCoins() async throws -> [AllCoinsModel]{
//        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&sparkline=true&price_change_percentage=24h") else {
//            throw URLError(.badURL) }
//        let (data,_) = try await URLSession.shared.data(from: url)
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return try decoder.decode([AllCoinsModel].self, from: data)
//    }
//}
//
//#Preview {
//    EditPortfolioView()
//}
