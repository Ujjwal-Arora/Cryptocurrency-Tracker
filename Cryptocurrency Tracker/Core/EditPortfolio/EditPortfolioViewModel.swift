//
//  EditPortfolioViewModel.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 15/09/24.
//

import Foundation
import SwiftUI

@MainActor
class EditPortfolioViewModel : ObservableObject{
    private var vm : HomeViewModel
    init(vm : HomeViewModel){
        self.vm = vm
    }
    @Published var selectedCoin : CoinModel?
    @Published var quantityText = ""
    var calculatedValue : Double? {
        
        return (Double(quantityText) ?? 0) * (selectedCoin?.currentPrice ?? 0)
    }
    
    func saveQuantity(){
        if let selectedCoin = selectedCoin, let index = vm.allCoins.firstIndex(where: {$0.id == selectedCoin.id}){
            vm.allCoins[index].holdingsQuantity = Double(quantityText)
        }
        savePortfolioCoins()
    }
    
    private func savePortfolioCoins(){
        if let encodedPortfolioCoins = try? JSONEncoder().encode(vm.portfolioCoins){
            UserDefaults.standard.setValue(encodedPortfolioCoins, forKey: "portfolioCoins")
        }
    }
}
