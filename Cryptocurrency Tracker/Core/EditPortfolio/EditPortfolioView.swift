//
//  EditPortfolioView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 14/09/24.
//

import SwiftUI

struct EditPortfolioView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var homeVM : HomeViewModel
    @StateObject var portfolioVM : EditPortfolioViewModel
    init(homeVM : HomeViewModel) {
        _portfolioVM = StateObject(wrappedValue: EditPortfolioViewModel(vm: homeVM))
    }
    
    var body: some View {
        VStack{
            searchBarVisibility

            coinList
            
            portfolioInputSection
            Spacer()
            
        }
        .navigationTitle("Edit Portfolio")
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    portfolioVM.saveQuantity()
                    homeVM.loadSavedPortfolioCoins()
                    dismiss()
                    
                }, label: {
                    Text("Save")
                        .opacity(Double(portfolioVM.quantityText) ?? 0 >= 0 ? 1 : 0)
                })
            }
            
        }
    }
}

#Preview {
    NavigationStack{
        EditPortfolioView(homeVM: HomeViewModel())
            .environmentObject(HomeViewModel())
    }
}

extension EditPortfolioView {
    private var coinList : some View{
        ScrollView(.horizontal) {
            LazyHStack{
                ForEach(homeVM.sortedAndFilteredAllCoins) { coin in
                    Button(action: {
                        withAnimation(.easeIn) {
                            portfolioVM.selectedCoin = coin
                            portfolioVM.quantityText = ""
                        }
                    }, label: {
                        VStack{
                            CoinImageView(imageUrlSting: coin.image ?? "")
                            Text(coin.symbol?.uppercased() ?? "")
                                .font(.headline)
                            
                            Text(coin.name ?? "")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .foregroundStyle(.black)
                        .frame(width: 70, height: 110)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(coin == portfolioVM.selectedCoin ? Color.green : Color.gray, lineWidth: 2)
                        )
                    })
                    
                }
            }.padding()
        }.frame(height: 200)

    }
    private var portfolioInputSection : some View {
        VStack{
            if let item = portfolioVM.selectedCoin{
                
                HStack{
                    Text("Current Price of \(item.symbol?.uppercased() ?? "") :")
                    Spacer()
                    Text(item.currentPrice?.currencyFormatter() ?? "")
                }
                Divider()
                HStack{
                    Text("Current holdings quantity :")
                    TextField(item.holdingsQuantity?.quantityFormatter() ?? "0.0", text: $portfolioVM.quantityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad) //will stop from negative value as well
                }
                Divider()
                HStack{
                    Text("Current holdings value :")
                    Spacer()
                    Text((portfolioVM.quantityText.isEmpty ? item.holdingsValue.currencyFormatter() : portfolioVM.calculatedValue?.currencyFormatter()) ?? "" )
                }
            }
        }
        .padding()
        .font(.headline)
    }
    private var searchBarVisibility : some View{
        Text("Click to enter the quantity")
            .font(.footnote)
            .searchable(text: $homeVM.searchText) //for some reason seacrhable does work with scrollView maybe some interference so used this
        
    }
}
