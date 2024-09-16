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
            highlightBar
            
            headerTitles
            
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
    
    private var headerTitles : some View {
        GeometryReader(content: { fullView in
            HStack{
                toggleSortOption(title: "Coin", option1: .marketCapRankAscending, option2: .marketCapRankDescending)
                    .padding(.leading,25)
                
                Spacer()
                
                if vm.showPortfolio {
                    toggleSortOption(title: "Holding", option1: .holdingsValueAscending, option2: .holdingsValueDescending)
                        .frame(width: fullView.size.width/3.5,alignment: .leading)
                }
                
                toggleSortOption(title: "Price", option1: .priceAscending, option2: .priceDescending)
                    .frame(width: fullView.size.width/3.1,alignment: .leading)

            }
            .foregroundStyle(.gray)
            .font(.subheadline)
        }).frame(height: 20)
    }
    private var highlightBar : some View{
        HStack{

            StatsView(title: "My Portfolio", value: vm.holdingsValueSum.rounded().currencyFormatter(), percentageChange: vm.holdingsValuePercentageChange)
            
                StatsView(title: "Top Gainer", value: vm.maxGainer?.symbol?.uppercased() ?? "", percentageChange: vm.maxGainer?.priceChangePercentage24H)
                StatsView(title: "Top Loser", value: vm.maxLoser?.symbol?.uppercased() ?? "", percentageChange: vm.maxLoser?.priceChangePercentage24H)
            }
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
