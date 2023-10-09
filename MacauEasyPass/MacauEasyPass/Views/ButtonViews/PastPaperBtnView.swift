//
//  PastPaperBtnView.swift
//  MacauEasyPass
//
//  Created by 楊潤泰 on 2023/9/30.
//

import SwiftUI

struct PastPaperBtnView: View {
    let title: String
    let imageText: String
    
    var body: some View {
        ZStack (alignment: .trailing){
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width-20, height: 50)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                VStack {
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                }.padding()
            }
            Image(systemName: imageText)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .opacity(0.2)
                .frame(width: 30)
                .padding(.trailing, 10)
        }
    }
}

#Preview {
    PastPaperBtnView(title: "Text", imageText: "pencil")
}
