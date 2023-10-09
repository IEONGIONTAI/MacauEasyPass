//
//  AnswerBtnView.swift
//  MacauEasyPass
//
//  Created by 楊潤泰 on 2023/10/1.
//

import SwiftUI

extension String {
    func dynamicSize() -> Font {
        let length = self.count
        
        switch length {
        case 0..<45:
            return .title3
        case 45..<82:
            return .system(size: 16)
        case 82..<1000:
            return .system(size: 14)
        default:
            return .body
        }
    }
}

func frameDynamicSize(length : Int) -> CGFloat {
    switch length {
    case 0..<14:
        return 40
    case 14..<44:
        return 80
    case 44..<200:
        return 100
    default:
        return 50
    }
}
 
struct AnswerBtnView: View {
    @State var rectangleColor: Color = .clear
    @State private var offset: CGFloat = 0
    @Binding var isSelected: Bool?
    let questionNum: Int
    @Binding var correctCount: Int
    let answer: String
    let choose: String
    let correct: Bool
    var body: some View {
             ZStack(alignment: .leading) {
                 Text(answer)
                     .padding(.leading, 60)
                     .padding(.trailing, 10)
                     .frame(width: UIScreen.main.bounds.width-20, height: frameDynamicSize(length: answer.count))
                     .background(
                         ZStack(alignment: .leading) {
                             if isSelected ?? false && correct {
                                 RoundedRectangle(cornerRadius: 20)
                                     .fill(.green)  // 使用fill()并应用rectangleColor
                                     .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.black, lineWidth: 1)
                                     )
                                     .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)

                             }else {
                                 RoundedRectangle(cornerRadius: 20)
                                     .fill(rectangleColor)  // 使用fill()并应用rectangleColor
                                     .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.black, lineWidth: 1)
                                     )
                                     .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                             }
                             Image(systemName: "\(choose).circle")
                                 .padding(10)
                                 .font(.system(size: 20))
                                 .foregroundColor(.black)
                         }
                            .animation(Animation.easeInOut(duration: 0.1))
                     )
                     .foregroundColor(.black)
                     .font(answer.dynamicSize())
             }
             .contentShape(Rectangle())
             .onChange(of: questionNum) {
                 rectangleColor = .clear
             }
             .onTapGesture {
                  if(isSelected == nil) {
                      if correct == false {
                          rectangleColor = .red  // 点击时改变颜色为红色
                      } else if correct == true{
                          rectangleColor = .green
                          correctCount += 1
                      }
                      isSelected = true
                  }
              }
        
    }
}

#Preview {
    VStack(spacing: 30){
        Spacer()
        AnswerBtnView(isSelected: .constant(false), questionNum: 0, correctCount: .constant(0), answer: "答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案", choose: "a", correct: false)
        AnswerBtnView(isSelected: .constant(false), questionNum: 0, correctCount: .constant(0), answer: "答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答案答答案答案答案答案答", choose: "b", correct: false)
        AnswerBtnView(isSelected: .constant(false), questionNum: 0, correctCount: .constant(0), answer: "答案12331232131231211111111111111232131231231", choose: "c", correct: false)
        AnswerBtnView(isSelected: .constant(false), questionNum: 0, correctCount: .constant(0), answer: "答案1233123213123121232131231231", choose: "d", correct: false)
    }
}
