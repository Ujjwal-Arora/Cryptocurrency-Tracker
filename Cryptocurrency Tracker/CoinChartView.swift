//
//  CoinChartView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 13/09/24.
//

import SwiftUI
import Charts

struct CoinChartView: View {
    let coin : AllCoinsModel
    @State private var visibleCount = 0
    private var filteredPrices : [Double] {
        currentTimeInterval == "7 Days" ? coin.sparklineIn7D?.price ?? [] : coin.sparklineIn7D?.price?.suffix(24) ?? []
    }
    private var lineColor: Color {
        (filteredPrices.last ?? 0) - (filteredPrices.first ?? 0) >= 0 ? Color.green : Color.red
    }
    
    private var maxPrice: Double {
        filteredPrices.max() ?? 0
    }
    private var minPrice: Double {
        filteredPrices.min() ?? 0
    }
    var timeIntervals = ["1 Day","7 Days"]
    @State private var currentTimeInterval = "7 Days"
    
    
    
    var body: some View {
        Text(coin.id ?? "")
        Text(coin.sparklineIn7D?.price?.count.formatted() ?? "")
        Text(coin.sparklineIn7D?.price?.first?.formatted() ?? "")
        
        if !filteredPrices.isEmpty{
            
            VStack(spacing : 20){
                Picker("time", selection: $currentTimeInterval) {
                    ForEach(timeIntervals,id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                    .onChange(of: currentTimeInterval) { _, _ in
                        visibleCount = 0
                        animateChart()
                    }
                Chart{
                    //chart wants x and y coordinate for a point so enumerated gives a tuple (index/offset,value)
                    //.prefix is like trim here
                    ForEach(Array(filteredPrices.prefix(visibleCount).enumerated()),id: \.offset){ index,value in
                        LineMark(
                            x: PlottableValue.value("Day", index),
                            y: PlottableValue.value("Price", value)
                        )
                    }
                }
                
                .foregroundStyle(lineColor)
                .shadow(color: lineColor, radius: 5)
                .shadow(color: lineColor, radius: 10, y: 10)
                .shadow(color: lineColor, radius: 10, y: 20)
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .chartYScale(domain: minPrice...maxPrice)
                    
                .frame(height: 250)
                .background(content: {
                    chartGrids
                })
                
                HStack{
                    Text(Date().addingTimeInterval(-7*86400).formatted(date: .abbreviated, time: .omitted))
                        .opacity(currentTimeInterval == "7 Days" ? 1 : 0)
                    Spacer()
                    Text(Date().formatted(date: .abbreviated, time: .omitted))

                }
            }.font(.caption)
                .foregroundStyle(.gray)
                .onAppear(perform: {
                    animateChart()
                })

        }
    }
    private var chartGrids: some View {
        VStack(alignment : .leading) {
            Divider()
            Text(maxPrice.formatted())
            Spacer()
            Divider()
            Spacer()
            Text(minPrice.formatted())
            Divider()
        }
    }
    private func animateChart(){
        for (index,_) in Array(filteredPrices.enumerated()){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.004*Double(index)){
                if visibleCount <= filteredPrices.count{
                    withAnimation(.easeIn) {
                        visibleCount += 1
                    }
                }
            }
        }
    }
}

#Preview {
    CoinChartView(coin: Example().coin)
}
