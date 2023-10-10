//
//  MockTestView.swift
//  MacauEasyPass
//
//  Created by 楊潤泰 on 2023/9/30.
//

import SwiftUI


extension String {
    func dynamicFontSize() -> Font {
        let length = self.count
        
        switch length {
        case 0..<60:
            return .title
        case 60..<80:
            return .title2
        case 80..<200:
            return .title3
        default:
            return .body
        }
    }
}

struct MockTestView: View {
    let mockTestType: String
    @ObservedObject var adManager = InterstitialAdManager()
    @ObservedObject var apiFetcher = APIFetcher()
    
    @State var isSelected: Bool? = nil
    @State var isFinished: Bool? = nil
    
    @State private var hasFetchedData: Bool = false
    
    @State var questionNum : Int = 0
    @State var correctCount : Int = 0
    
    var body: some View {
        if isFinished != true {
            VStack {
                if let data = apiFetcher.jsonData {
                    Text("總共 \(data.count) 題")
                    // 例如：显示第一个问题
                    Text("第 \(questionNum+1) 題")
                        .font(.title)
                        .foregroundColor(.black)
                    HStack {
                        Text("\(data[questionNum].Question)")
                            .font(data[questionNum].Question.dynamicFontSize())
                            .foregroundColor(.black)
                            .padding(.top, 5)
                            .padding(.horizontal, 13)
                    }
                    Spacer()
                    HStack {
                        if(isSelected != nil && questionNum+1 != data.count && data[questionNum].Explain != "") {
                            Text("解釋：\(data[questionNum].Explain)")
                                .font(.system(size: 20))
                                .foregroundColor(.green)
                                .padding(.top, 5)
                                .padding(.horizontal, 5)
                        }
                    }
                    HStack {
                        Spacer()
                        if(isSelected != nil && questionNum+1 != data.count) {
                            ZStack() {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40)
                                Text("下一題")
                            }
                            .padding(.trailing, 10)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                questionNum += 1
                                isSelected = nil
                                if adManager.isAdLoaded && questionNum%3 == 0 {  // 確保廣告已經加載完成
                                    adManager.showAd()
                                } else {
                                    print("Ad is not loaded yet.")
                                }
                            }
                        }else if questionNum+1 == data.count && isSelected == true{
                            ZStack() {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40)
                                Text("完成")
                            }
                            .padding(.trailing, 10)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                isFinished = true
                            }
                        }
                    }
                    VStack (spacing:10){
                        ForEach(Array(data[questionNum].Options.enumerated()), id: \.element) { (index, option) in
                            let choice = String(UnicodeScalar(97 + index)!)
                            if(option == data[questionNum].Answer) {
                                AnswerBtnView(isSelected: $isSelected, questionNum: questionNum, correctCount: $correctCount, answer: "\(option)", choose: choice, correct: true)
                            }else {
                                AnswerBtnView(isSelected: $isSelected, questionNum: questionNum, correctCount: $correctCount, answer: "\(option)", choose: choice, correct: false)
                            }
                        }
                    }
                } else if let error = apiFetcher.error {
                    // 显示错误
                    Text(error.localizedDescription).foregroundColor(.red)
                } else {
                    LoadingView()
                }
            }.onAppear(perform: {
                if !hasFetchedData {
                    apiFetcher.fetchDataForType(mockTestType)
                    hasFetchedData = true
                }
            })
        }else if isFinished == true {
            ScoreSummaryView(userScore: Int((Double(correctCount) / Double(questionNum+1)) * 100), correctQuestions: correctCount, totalQuestions: questionNum+1)

        }
    }
    
}

#Preview {
    MockTestView(mockTestType: "20_MockTest")
}
