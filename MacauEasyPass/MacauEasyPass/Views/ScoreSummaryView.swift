//
//  ScoreSummaryView.swift
//  MacauEasyPass
//
//  Created by 楊潤泰 on 2023/10/2.
//

import SwiftUI

struct ScoreSummaryView: View {
    // 假設最高分為100，最低分為0
    let maxScore = 100
    let minScore = 0

    // 這些應該是從外部或業務邏輯中取得的
    @State var userScore: Int = 75
    @State var correctQuestions: Int = 15
    @State var totalQuestions: Int = 20

    @State private var isAppeared: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            // 分數展示
            Text("你的分數")
                .font(.largeTitle)
                .foregroundColor(.gray)

            Text("\(userScore)")
                .font(.system(size: 80))
                .fontWeight(.bold)
                .padding()

            // 進度條
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .foregroundColor(Color.gray.opacity(0.1))
                    .frame(width: 200, height: 200)

                Circle()
                    .trim(from: 0.0, to: CGFloat(userScore) / CGFloat(maxScore))
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: 270))
                    .frame(width: 200, height: 200)
                    .animation(.easeInOut, value: userScore)

                VStack {
                    Text("\(userScore)%")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("得分百分比")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
            }

            // 答對/答錯的題目數
            HStack(spacing: 50) {
                VStack {
                    Text("\(correctQuestions)")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                    Text("答對的題目")
                        .font(.headline)
                        .foregroundColor(.gray)
                }

                VStack {
                    Text("\(totalQuestions - correctQuestions)")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text("答錯的題目")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }

            Spacer()
        }
        .padding()
        .onAppear() {
            withAnimation {
                self.isAppeared = true
            }
        }
        .opacity(isAppeared ? 1.0 : 0.0)  // 使用三元運算符來控制不透明度
    }
}

#Preview {
    ScoreSummaryView()
}
