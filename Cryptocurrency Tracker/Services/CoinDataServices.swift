//
//  CoinDataServices.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 14/09/24.
//

import Foundation

class CoinDataServices{
    func fetchAllCoins() async throws -> [CoinModel]{
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&sparkline=true&price_change_percentage=24h") else {
            throw URLError(.badURL) }
        let (data,_) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([CoinModel].self, from: data)
    }
}
