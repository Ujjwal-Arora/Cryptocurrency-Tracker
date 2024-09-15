//
//  Cryptocurrency_TrackerApp.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 12/09/24.
//

import SwiftUI

@main
struct Cryptocurrency_TrackerApp: App {
    @StateObject private var vm = HomeViewModel()
    @State private var showSplashScreen = true

    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationStack{
                    HomeView()
                }.environmentObject(vm)
                .toolbar(.hidden)
                
                if showSplashScreen{
                    SplashScreenView(isPresented: $showSplashScreen)
                }
            }
        
        }
    }
}
