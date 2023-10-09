//
//  LoadingView.swift
//  MacauEasyPass
//
//  Created by 楊潤泰 on 2023/10/5.
//

import SwiftUI

struct LoadingView: View {
    @State private var offsetAmount: CGFloat = 10.0
    
    var body: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .offset(x: offsetAmount, y: offsetAmount)
                .animation(
                    Animation.easeInOut(duration: 0.5)
                        .repeatForever(autoreverses: true)
                        .delay(0.2),
                    value: offsetAmount
                )
            Text("載入中...")
                .font(.title)
                .padding(.top)
        }
        .onAppear() {
            withAnimation {
                offsetAmount = -10.0
            }
        }
    }
}

#Preview {
    LoadingView()
}
