//
//  EditPortfolioView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 14/09/24.
//

import SwiftUI

struct EditPortfolioView: View {
    @ObservedObject var vm : HomeViewModel
    
    var body: some View {
        ScrollView{
            
            coinList
            portfolioInputSection
            
        }
        .navigationTitle("Edit Portfolio")
        .searchable(text: $vm.searchText)
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    vm.quantityText = ""
                    vm.selectedCoin = nil
                    vm.showEditPortfolioView = false
                }, label: {
                    Text("Cancel")
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    vm.saveQuantity()
                    vm.quantityText = ""
                    vm.selectedCoin = nil
                    vm.showEditPortfolioView = false
                }, label: {
                    Text("Save")
                        .opacity(Double(vm.quantityText) ?? 0 > 0 ? 1 : 0)
                })
            }
            
        }
    }
}

#Preview {
    NavigationStack{
        EditPortfolioView(vm: HomeViewModel())
    }
}

extension EditPortfolioView {
    
    private var coinList : some View{
        ScrollView(.horizontal) {
            LazyHStack{
                ForEach(vm.sortedAndFilteredAllCoins) { coin in
                    Button(action: {
                        withAnimation(.easeIn) {
                            vm.selectedCoin = coin
                            vm.quantityText = ""
                        }
                    }, label: {
                        VStack{
                            AsyncImage(url: URL(string: coin.image ?? ""), scale: 5)
                            Text(coin.symbol?.uppercased() ?? "")
                                .font(.headline)
                            
                            Text(coin.name ?? "")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .foregroundStyle(.black)
                        .frame(width: 70, height: 90)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(coin == vm.selectedCoin ? Color.green : Color.gray, lineWidth: 2)
                        )
                    })
                    
                }
            }.padding()
        }
    }
    private var portfolioInputSection : some View {
        VStack{
            if let item = vm.selectedCoin{
                
                HStack{
                    Text("Current Price of \(item.symbol?.uppercased() ?? "") :")
                    Spacer()
                    Text(item.currentPrice?.currencyFormatter() ?? "")
                }
                Divider()
                HStack{
                    Text("Current holdings quantity :")
                    TextField(item.holdingsQuantity?.quantityFormatter() ?? "0.0", text: $vm.quantityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad) //will stop from negative value as well
                }
                Divider()
                HStack{
                    Text("Current holdings value :")
                    Spacer()
                    Text((vm.quantityText.isEmpty ? item.holdingsValue.currencyFormatter() : vm.calculatedValue?.currencyFormatter()) ?? "" )
                }
            }
        }
        .padding()
        .font(.headline)
    }
}
