//
//  HomeView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 12/09/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        
        VStack {
            header
            
            coinList
                .navigationDestination(for: CoinModel.self) { coin in
                    CoinDetailView(coin: coin)
                }
            
        }.navigationDestination(isPresented: $vm.showEditPortfolioView, destination: {
            EditPortfolioView(vm: vm)
        })
        .navigationTitle(vm.showEditPortfolioView ? "Portfolio Prices" : "Live Prices" )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    vm.showEditPortfolioView = true
                }, label: {
                    Image(systemName: "plus.circle")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    withAnimation {
                        vm.showPortfolio.toggle()
                    }
                }, label: {
                    Image(systemName: vm.showPortfolio ? "chevron.backward.circle" : "chevron.forward.circle")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                })
            }
        }
        .searchable(text: $vm.searchText)
    }
}


#Preview {
    NavigationStack{
        HomeView()
    }
}

extension HomeView{
    
    private var header : some View {
        HStack{
            Button(action: {
                if vm.sorting == .marketCapRankAscending{
                    vm.sorting = .marketCapRankDescending
                }else{
                    vm.sorting = .marketCapRankAscending
                }
            }, label: {
                HStack {
                    Text("Coin")
                    if vm.sorting == .marketCapRankAscending{
                        Image(systemName: "chevron.up")
                    }else if vm.sorting == .marketCapRankDescending {
                        Image(systemName: "chevron.down")
                    }
                }
            }).padding(.horizontal)
            Spacer()
            if vm.showPortfolio {
                Button(action: {
                    if vm.sorting == .holdingsValueAscending{
                        vm.sorting = .holdingsValueDescending
                    }else{
                        vm.sorting = .holdingsValueAscending
                    }
                }, label: {
                    HStack {
                        Text("Holdings")
                        if vm.sorting == .holdingsValueAscending{
                            Image(systemName: "chevron.up")
                        }else if vm.sorting == .holdingsValueDescending {
                            Image(systemName: "chevron.down")
                        }
                    }
                }).padding(.horizontal)
                
                //.frame(width: row.size.width / 3.3)
            }
            Button(action: {
                if vm.sorting == .priceAscending{
                    vm.sorting = .priceDescending
                }else{
                    vm.sorting = .priceAscending
                }
            }, label: {
                HStack {
                    Text("Price")
                    if vm.sorting == .priceAscending{
                        Image(systemName: "chevron.up")
                    }else if vm.sorting == .priceDescending {
                        Image(systemName: "chevron.down")
                    }
                }
            }).padding(.horizontal)
        }
    }
    private var coinList : some View{
        List {
            ForEach(vm.showPortfolio ? vm.portfolioCoins : vm.sortedAndFilteredAllCoins) { coin in
                NavigationLink(value: coin) {
                    RowView(coin: coin, showHoldingsColumn: vm.showPortfolio)
                }.listRowInsets(.none)
            }
        }
        .listStyle(.plain)
    }
}
