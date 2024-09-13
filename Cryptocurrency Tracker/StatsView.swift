//
//  StatsView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 12/09/24.
//

import SwiftUI

struct StatsView: View {
    let title : String
    let value : String
    var percentageChange : Double?
    @State private var searchText = ""


    var body: some View {
        VStack(alignment : .leading,spacing: 5){
            Text(title)
                .font(.caption)
            Text(value)
                .font(.subheadline)
                .bold()
            HStack(spacing : 5){
                Image(systemName: percentageChange ?? 0 >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                Text("\(percentageChange?.formatted() ?? "0")%")
            }
            .font(.caption)
            .foregroundStyle(percentageChange ?? 0 >= 0 ? Color.green : Color.red)
            .opacity(percentageChange == nil ? 0 : 1)
        }.padding()
        
            .searchable(text: $searchText)
        VStack{
            ScrollView{
                ForEach(0..<5,id: \.self){_ in
                    Text("sddf")
                        .foregroundStyle(.secondary)
                }}}
        
    }
}

#Preview {
    NavigationStack{
        StatsView(title: "Market Cap", value: "2100", percentageChange: 7.25)
    }
}
