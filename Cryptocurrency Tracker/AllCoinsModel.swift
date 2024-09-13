//
//  AllCoinsModel.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 12/09/24.
//

import Foundation

//JSON file
// url 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&sparkline=true&price_change_percentage=24h'
/*
 {
"id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
    "current_price": 5305118,
    "market_cap": 104727696027676,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 111381589769420,
    "total_volume": 2241258209307,
    "high_24h": 5439083,
    "low_24h": 5297370,
    "price_change_24h": -79372.45246928465,
    "price_change_percentage_24h": -1.47409,
    "market_cap_change_24h": -1627786373721.8594,
    "market_cap_change_percentage_24h": -1.53051,
    "circulating_supply": 19745468,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 6110932,
    "ath_change_percentage": -13.14201,
    "ath_date": "2024-03-14T07:10:36.635Z",
    "atl": 3993.42,
    "atl_change_percentage": 132814.49668,
    "atl_date": "2013-07-05T00:00:00.000Z",
    "last_updated": "2024-08-26T20:14:31.540Z",
    "sparkline_in_7d": {
      "price": [
        58774.585780204005,
        59033.05413379757,
        
      ]
    },
    "price_change_percentage_24h_in_currency": -1.4740940585285958
  }
  }
*/

struct AllCoinsModel : Identifiable,Codable,Hashable {
    let id, symbol, name: String?
    let image: String?
    let currentPrice : Double?
    let marketCap, marketCapRank : Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
}
struct SparklineIn7D : Codable,Hashable {
   let price: [Double]?
}
