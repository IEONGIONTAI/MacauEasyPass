//
//  ContentView.swift
//  MacauEasyPass
//
//  Created by 楊潤泰 on 2023/9/30.
//

import SwiftUI

struct ContentView: View {
    @State private var showSetting = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading){
                    // QuickStart View
                    Text("快速測驗")
                        .font(.system(size: 40))
                        .bold()
                    ScrollView(.horizontal) {
                        HStack {
                            NavigationLink(destination: MockTestView(mockTestType: "20_MockTest")) {
                                QuickStartButton(title: "快速測試", totalQuestion: 20, color: .blue)
                            }
                            NavigationLink(destination: MockTestView(mockTestType: "60_MockTest")) {
                                QuickStartButton(title: "模擬考試", totalQuestion: 60, color: .purple)
                            }
                        }
                    }
                    Spacer(minLength: 40)
                    // QuestionType view
                    Text("題目類型")
                        .font(.system(size: 40))
                        .bold()
                    HStack {
                        NavigationLink(destination: MockTestView(mockTestType: "law")) {
                            QuestionTypeButton(title: "法例題", description: "《基本法》", imageText: "book.fill")
                        }
                        NavigationLink(destination: MockTestView(mockTestType: "reading")) {
                            QuestionTypeButton(title: "語文理解", description: "閱讀能力", imageText: "abc")
                        }
                    }
                    HStack {
                        NavigationLink(destination: MockTestView(mockTestType: "math")) {
                            QuestionTypeButton(title: "數理邏輯", description: "邏輯思維", imageText: "brain.fill")
                        }
                        NavigationLink(destination: MockTestView(mockTestType: "computer")) {
                            QuestionTypeButton(title: "文書處理", description: "MS office", imageText: "folder")
                        }
                    }
                    Spacer(minLength: 40)
                    // PastPaper view
                    Text("歷年題目")
                        .font(.system(size: 40))
                        .bold()
                    VStack {
                        NavigationLink(destination: SettingView()) {
                            PastPaperBtnView(title: "2023 260考試題目", imageText: "pencil.and.outline")
                        }
                        NavigationLink(destination: SettingView()) {
                            PastPaperBtnView(title: "2023 430考試題目", imageText: "pencil.and.outline")
                        }
                        
                    }
                }
            }.padding()
            .navigationBarTitle("首頁", displayMode: .inline)
            .navigationBarItems(
                trailing:
                Button(action: {
                    showSetting = true
                }) {
                    Image(systemName: "gearshape")
                }
                .sheet(isPresented: $showSetting) {
                    SettingView()
                }
            )
            .navigationBarItems(
                leading:
                Button(action: {
                    showSetting = true
                }) {
                    HStack{
                        Text("無廣告版")
                    }
                }
                .sheet(isPresented: $showSetting) {
                    SettingView()
                }
            )
        }
    }
    
}

#Preview {
    ContentView()
}
