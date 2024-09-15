//
//  CoinImageView.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 16/09/24.
//

import SwiftUI
import Kingfisher

struct CoinImageView: View {
    var imageUrlSting : String
    enum Size {
        case small,medium
        
        var frameSize : CGFloat{
            switch self {
            case .small:
                return 25
            case .medium:
                return 50
            }
        }
    }
    var imageSize = Size.medium
    var body: some View {
        VStack{
            KFImage(URL(string: imageUrlSting))
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.frameSize,height: imageSize.frameSize)
        }
    }
}

#Preview {
    CoinImageView(imageUrlSting: MockData.exampleCoin.image ?? "")
}
