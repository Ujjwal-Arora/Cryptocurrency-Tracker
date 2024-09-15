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
                Text(percentageChange?.percentageFormatter() ?? "")
            }
            .font(.caption)
            .foregroundStyle(percentageChange ?? 0 >= 0 ? Color.green : Color.red)
            .opacity(percentageChange == nil ? 0 : 1)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .foregroundStyle(.gray)
        }
            
    }
}

#Preview {
    NavigationStack{
        StatsView(title: "Market Cap", value: "2100", percentageChange: 7.25)
    }
}
