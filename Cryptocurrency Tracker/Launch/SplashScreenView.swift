//
//  SplashScreenView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 15/09/24.
//

import SwiftUI


struct SplashScreenView: View {
    @Binding var isPresented : Bool
    @State private var scale : CGFloat = 1
    @State private var rotation = Angle(degrees: -90)
    @State private var showOriginalImage = true
    var body: some View {
        ZStack{
            Color.splashScreen
                .ignoresSafeArea()
            ZStack{
                Image(showOriginalImage ? "originalSplashScreen" : "whiteSplashScreen")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .scaleEffect(scale)
                    .rotationEffect(rotation)
                
            }.onAppear(perform: {
                withAnimation(.easeInOut(duration: 1.5)) {
                    scale = 2
                    rotation = Angle(degrees: 0)
                }
                for i in 0...13 {
                    DispatchQueue.main.asyncAfter(deadline: .now()  + Double(i) * 0.1){
                        showOriginalImage.toggle()
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    withAnimation(.easeIn(duration: 0.3)) {
                        scale = 200
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.3){
                    withAnimation(.easeIn(duration: 0.2)) {
                        isPresented = false

                    }
                }
            })
        }
    }
}

#Preview {
    SplashScreenView(isPresented: .constant(true))
}
