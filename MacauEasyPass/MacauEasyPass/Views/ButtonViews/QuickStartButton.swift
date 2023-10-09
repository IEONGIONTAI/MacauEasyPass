//
//  QuickStartButton.swift
//  MacauEasyPass
//
//  Created by 楊潤泰 on 2023/9/30.
//

import SwiftUI

struct QuickStartButton: View {
    let title: String
    let totalQuestion: Int
    let color: Color
    
    var body: some View {
        VStack {
            ZStack(alignment : .trailing){
                ZStack (alignment : .leading){
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .fill(color)
                        .frame(width: 320, height: 120)
                    VStack (alignment : .leading){
                        Text(title)
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                        Text("共\(totalQuestion)題")
                            .foregroundColor(.white)
                    }.padding()
                }
                Image(systemName: "pencil.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .opacity(0.2)
                    .frame(width: 120)
            }
        }.contentShape(Rectangle())
    }
}

#Preview {
    QuickStartButton(title: "標題", totalQuestion: 0, color: .blue)
}
