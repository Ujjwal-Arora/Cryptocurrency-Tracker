//
//  HomeView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 12/09/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    
    var body: some View {
        VStack {
            if vm.showPortfolio {
                StatsView(title: "Portfolio Value", value: vm.holdingsValueSum.currencyFormatter(), percentageChange: vm.holdingsValuePercentageChange)
            }
            header
            
            List {
                ForEach(vm.showPortfolio ? vm.portfolioCoins : vm.sortedAndFilteredAllCoins) { coin in
                    NavigationLink(value: coin) {
                        RowView(coin: coin, showHoldingsColumn: vm.showPortfolio)
                    }
                }
            }
            .listStyle(.plain)
            .navigationDestination(for: CoinModel.self) { coin in
                CoinDetailView(coin: coin)
            }
        }
        .navigationTitle(vm.showPortfolio ? "Portfolio Prices" : "Live Prices" )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    EditPortfolioView(homeVM: vm)
                } label: {
                    Image(systemName: "plus.circle")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
                
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
        HomeView().environmentObject(HomeViewModel())
    }
}

extension HomeView{
    
    private var header : some View {
        GeometryReader(content: { fullView in
            HStack{
                toggleSortOption(title: "Coin", option1: .marketCapRankAscending, option2: .marketCapRankDescending)
                    .padding(.leading,22)
                
                Spacer()
                
                if vm.showPortfolio {
                    toggleSortOption(title: "Holding", option1: .holdingsValueAscending, option2: .holdingsValueDescending)
                        .frame(width: fullView.size.width/3.8,alignment: .leading)
                }
                
                toggleSortOption(title: "Price", option1: .priceAscending, option2: .priceDescending)
                    .frame(width: fullView.size.width/2.9,alignment: .leading)

            }.foregroundStyle(.gray)
        }).frame(height: 20)
        
    }
    private func toggleSortOption(title : String, option1 : HomeViewModel.SortOptions, option2 : HomeViewModel.SortOptions) -> some View{
        Button(action: {
            vm.sorting = (vm.sorting == option1) ? option2 : option1
        }, label: {
            HStack {
                Text(title)
                if vm.sorting == option1{
                    Image(systemName: "chevron.up")
                }else if vm.sorting == option2 {
                    Image(systemName: "chevron.down")
                }
            }
        })
    }
}
