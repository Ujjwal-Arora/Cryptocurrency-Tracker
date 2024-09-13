////
////  CoinDataModel.swift
////  Cryptocurrency Tracker
////
////  Created by Ujjwal Arora on 12/09/24.
////
//
//import Foundation
//
////JSON File
//// url = 'https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false' \
//
///*
// {
//   "id": "bitcoin",
//   "symbol": "btc",
//   "name": "Bitcoin",
//   "web_slug": "bitcoin",
//   "asset_platform_id": null,
//   "platforms": {
//     "": ""
//   },
//   "detail_platforms": {
//     "": {
//       "decimal_place": null,
//       "contract_address": ""
//     }
//   },
//   "block_time_in_minutes": 10,
//   "hashing_algorithm": "SHA-256",
//   "categories": [
//     "Cryptocurrency",
//     "Layer 1 (L1)",
//     "FTX Holdings",
//     "Proof of Work (PoW)",
//     "Bitcoin Ecosystem",
//     "GMCI 30 Index"
//   ],
//   "preview_listing": false,
//   "public_notice": null,
//   "additional_notices": [],
//   "description": {
//     "en": "Bitcoin is the first successful internet money based on peer-to-peer technology; whereby no central bank or authority is involved in the transaction and production of the Bitcoin currency. It was created by an anonymous individual/group under the name, Satoshi Nakamoto. The source code is available publicly as an open source project, anybody can look at it and be part of the developmental process.\r\n\r\nBitcoin is changing the way we see money as we speak. The idea was to produce a means of exchange, independent of any central authority, that could be transferred electronically in a secure, verifiable and immutable way. It is a decentralized peer-to-peer internet currency making mobile payment easy, very low transaction fees, protects your identity, and it works anywhere all the time with no central authority and banks.\r\n\r\nBitcoin is designed to have only 21 million BTC ever created, thus making it a deflationary currency. Bitcoin uses the <a href=\"https://www.coingecko.com/en?hashing_algorithm=SHA-256\">SHA-256</a> hashing algorithm with an average transaction confirmation time of 10 minutes. Miners today are mining Bitcoin using ASIC chip dedicated to only mining Bitcoin, and the hash rate has shot up to peta hashes.\r\n\r\nBeing the first successful online cryptography currency, Bitcoin has inspired other alternative currencies such as <a href=\"https://www.coingecko.com/en/coins/litecoin\">Litecoin</a>, <a href=\"https://www.coingecko.com/en/coins/peercoin\">Peercoin</a>, <a href=\"https://www.coingecko.com/en/coins/primecoin\">Primecoin</a>, and so on.\r\n\r\nThe cryptocurrency then took off with the innovation of the turing-complete smart contract by <a href=\"https://www.coingecko.com/en/coins/ethereum\">Ethereum</a> which led to the development of other amazing projects such as <a href=\"https://www.coingecko.com/en/coins/eos\">EOS</a>, <a href=\"https://www.coingecko.com/en/coins/tron\">Tron</a>, and even crypto-collectibles such as <a href=\"https://www.coingecko.com/buzz/ethereum-still-king-dapps-cryptokitties-need-1-billion-on-eos\">CryptoKitties</a>."
//   },
//   "links": {
//     "homepage": [
//       "http://www.bitcoin.org",
//       "",
//       ""
//     ],
//     "whitepaper": "https://bitcoin.org/bitcoin.pdf",
//     "blockchain_site": [
//       "https://mempool.space/",
//       "https://blockchair.com/bitcoin/",
//       "https://btc.com/",
//       "https://btc.tokenview.io/",
//       "https://www.oklink.com/btc",
//       "https://3xpl.com/bitcoin",
//       "",
//       "",
//       "",
//       ""
//     ],
//     "official_forum_url": [
//       "https://bitcointalk.org/",
//       "",
//       ""
//     ],
//     "chat_url": [
//       "",
//       "",
//       ""
//     ],
//     "announcement_url": [
//       "",
//       ""
//     ],
//     "twitter_screen_name": "bitcoin",
//     "facebook_username": "bitcoins",
//     "bitcointalk_thread_identifier": null,
//     "telegram_channel_identifier": "",
//     "subreddit_url": "https://www.reddit.com/r/Bitcoin/",
//     "repos_url": {
//       "github": [
//         "https://github.com/bitcoin/bitcoin",
//         "https://github.com/bitcoin/bips"
//       ],
//       "bitbucket": []
//     }
//   },
//   "image": {
//     "thumb": "https://coin-images.coingecko.com/coins/images/1/thumb/bitcoin.png?1696501400",
//     "small": "https://coin-images.coingecko.com/coins/images/1/small/bitcoin.png?1696501400",
//     "large": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"
//   },
//   "country_origin": "",
//   "genesis_date": "2009-01-03",
//   "sentiment_votes_up_percentage": 77.95,
//   "sentiment_votes_down_percentage": 22.05,
//   "watchlist_portfolio_users": 1669797,
//   "market_cap_rank": 1,
//   "status_updates": [],
//   "last_updated": "2024-09-12T14:14:08.018Z"
// }
// */
//
//struct CoinDetailModel : Codable {
//    let id, symbol, name: String?
//    let blockTimeInMinutes: Int?
//    let hashingAlgorithm: String?
//    let categories: [String]
//    let description: Description?
//    let links: Links?
//    let sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double?
//}
//struct Description : Codable {
//    let en: String?
//}
//struct Links : Codable {
//    let homepage: [String]?
//    let subredditURL: String?
//}
//
//
//
//
//
//
//
//func fetchCoinData() async throws -> CoinDetailModel? {
//    do {
//        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
//            print("invalid url")
//            return nil
//        }
//        let (data,_) = try await URLSession.shared.data(from: url)
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return try decoder.decode(CoinDetailModel.self, from: data)
//        
//    }catch {
//        print("error fetching coin details\(error.localizedDescription)")
//        return nil
//    }
//
//}
//
//
//
//HStack {
//    StatsView(title: coinDetailts?.categories[1] ?? "no detail", value: coinDetailts?.categories[3] ?? "no detail")
//    
//    let (publicSentimentTitle,publicSentimentPercentage) = coinDetailts?.sentimentVotesUpPercentage ?? 0 >= 50 ? ("Buy",coinDetailts?.sentimentVotesUpPercentage) : ("Sell",coinDetailts?.sentimentVotesDownPercentage)
//    
//    StatsView(title: "Public Sentiments", value: publicSentimentTitle, percentageChange: publicSentimentPercentage)
//}
//Text(coinDetailts?.id ?? "no coin")
//
//Divider()


//
//
//
//contentview file
////
////  ContentView.swift
////  Cryptocurrency Tracker
////
////  Created by Ujjwal Arora on 12/09/24.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @State private var coinDetailts : CoinDetailModel?
//    @State private var allCoins = [AllCoinsModel]()
//    var body: some View {
//        
//        VStack {
//            Text("Hello, world!")
//            
//            HStack {
//                StatsView(title: coinDetailts?.categories[1] ?? "no detail", value: coinDetailts?.categories[3] ?? "no detail")
//                
//                let (publicSentimentTitle,publicSentimentPercentage) = coinDetailts?.sentimentVotesUpPercentage ?? 0 >= 50 ? ("Buy",coinDetailts?.sentimentVotesUpPercentage) : ("Sell",coinDetailts?.sentimentVotesDownPercentage)
//                
//                StatsView(title: "Public Sentiments", value: publicSentimentTitle, percentageChange: publicSentimentPercentage)
//            }
//            Text(coinDetailts?.id ?? "no coin")
//            
//            Divider()
//            Text(allCoins.first?.symbol ?? "no coin")
//            Text(allCoins.first?.currentPrice?.formatted() ?? "no price")
//            Text(allCoins.first?.sparklineIn7D?.price?.first?.formatted() ?? "no sparkline")
//
//            
//            
//            
//            ForEach(allCoins){coin in
//                
//            }
//            
//            
//            
//            
//            
//        }
//        .padding()
//        .task {
//            //    coinDetailts = try? await fetchCoinData()
//            allCoins = (try? await allCoins()) ?? []
////            if let ww = allCoins{
////
////                print(ww.first)
////                print("done")
////            } else {return}
//        }
//    }
//    func fetchCoinData() async throws -> CoinDetailModel? {
//        do {
//            guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
//                print("invalid url")
//                return nil
//            }
//            let (data,_) = try await URLSession.shared.data(from: url)
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode(CoinDetailModel.self, from: data)
//            
//        }catch {
//            print("error fetching coin details\(error.localizedDescription)")
//            return nil
//        }
//
//    }
//    func allCoins() async throws -> [AllCoinsModel]?{
//        do {
//            guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&sparkline=true&price_change_percentage=24h") else {
//                print("invalid url")
//                return nil
//            }
//            let (data,_) = try await URLSession.shared.data(from: url)
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode([AllCoinsModel].self, from: data)
//            
//        }catch {
//            print("error fetching all coins list \(error.localizedDescription)")
//            return nil
//        }
//
//    }
//    
//}
//
//
//#Preview {
//    ContentView()
//}
//
