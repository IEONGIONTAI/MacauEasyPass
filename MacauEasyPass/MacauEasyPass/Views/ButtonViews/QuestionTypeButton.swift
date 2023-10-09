//
//  QuestionTypeButton.swift
//  MacauEasyPass
//
//  Created by 楊潤泰 on 2023/9/30.
//

import SwiftUI

struct QuestionTypeButton: View {
    let title: String
    let description: String
    let imageText: String
    
    var body: some View {
        ZStack(alignment : .trailing){
            ZStack (alignment: .leading){
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: UIScreen.main.bounds.width/2-20, height: 100)
                    .foregroundColor(.blue)
                VStack (alignment: .leading){
                    Text(title)
                        .foregroundStyle(.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text(description)
                        .foregroundStyle(.white)
                }.padding()
            }
            Image(systemName: imageText)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .opacity(0.2)
                .frame(width: 80)
                .padding(.trailing, 5)
        }
    }
}

#Preview {
    QuestionTypeButton(title: "Title", description: "desc", imageText: "square.and.pencil.circle")
}
