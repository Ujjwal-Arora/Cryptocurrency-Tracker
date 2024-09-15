//
//  HomeViewModel.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 14/09/24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var allCoins = [CoinModel]()
    @Published var searchText = ""
    @Published var showPortfolio = false
    
    var portfolioCoins : [CoinModel] {
        return sortedAndFilteredAllCoins.filter { coin in
            coin.holdingsValue != 0
        }
    }
    init() {
        Task{
            do {
                allCoins = try await CoinDataServices().fetchAllCoins()
                loadSavedPortfolioCoins()
            } catch {
                print("Failed to fetch all coins \(error.localizedDescription)")
            }
        }
    }
    @Published var sorting : SortOptions = SortOptions.marketCapRankAscending
    enum SortOptions {
        case marketCapRankAscending, marketCapRankDescending, holdingsValueAscending, holdingsValueDescending, priceAscending, priceDescending
    }
    

    var sortedAndFilteredAllCoins : [CoinModel]{
        var filteredAllCoins : [CoinModel]{
            if searchText.isEmpty {
                return allCoins
            }else {
                return allCoins.filter { coin in
                    (coin.name?.lowercased() ?? "").contains(searchText.lowercased()) ||
                    (coin.id?.lowercased() ?? "").contains(searchText.lowercased()) ||
                    (coin.symbol?.lowercased() ?? "").contains(searchText.lowercased())
                }
            }
            
        }
        switch sorting {
        case  .marketCapRankDescending:
            return filteredAllCoins.sorted {$0.marketCapRank ?? 0 > $1.marketCapRank ?? 0 }
        case  .marketCapRankAscending:
            return filteredAllCoins.sorted {$0.marketCapRank ?? 0 < $1.marketCapRank ?? 0 }
        case  .holdingsValueDescending:
            return filteredAllCoins.sorted {$0.holdingsValue > $1.holdingsValue }
        case  .holdingsValueAscending:
            return filteredAllCoins.sorted {$0.holdingsValue < $1.holdingsValue }
        case  .priceDescending:
            return filteredAllCoins.sorted {$0.currentPrice ?? 0 > $1.currentPrice ?? 0 }
        case  .priceAscending:
            return filteredAllCoins.sorted {$0.currentPrice ?? 0 < $1.currentPrice ?? 0 }
        }
    }
    
    var holdingsValueSum: Double {
        return portfolioCoins.reduce(0) { partialSum, coin in
            partialSum + coin.holdingsValue
        }
    }
    
    var holdingsValuePercentageChange: Double {
        let previousTotalValue = portfolioCoins.reduce(0) { partialSum, coin in
            let percentageChangeInDecimal = (coin.priceChangePercentage24H  ?? 0) / 100
            let previousValue = coin.holdingsValue / (1 + percentageChangeInDecimal)
            return partialSum + previousValue
        }
        let percentageChange = ((holdingsValueSum - previousTotalValue) / previousTotalValue) * 100
        return percentageChange
    }
    
    
    func loadSavedPortfolioCoins(){
        if let savedData = UserDefaults.standard.data(forKey: "portfolioCoins"), let decodedPortfolioCoins = try? JSONDecoder().decode([CoinModel].self, from: savedData){
            for portfolioCoin in decodedPortfolioCoins {
                if let index = allCoins.firstIndex(where: {$0.id == portfolioCoin.id}){
                    allCoins[index].holdingsQuantity = portfolioCoin.holdingsQuantity
                } 
            }
        }
    }
}
