//
//  SettingView.swift
//  MacauEasyPass
//
//  Created by 楊潤泰 on 2023/10/3.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("onlyShowNewQuestions") var onlyShowNewQuestions: Bool = false
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var fontSize: Double = 16

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("喜好設定").font(.headline)) {
                    HStack {
                        Image(systemName: "eye.slash.fill").foregroundColor(.red)
                        Toggle("盡量顯示未嘗試過的題目", isOn: $onlyShowNewQuestions)
                    }
                }
                
                Section(header: Text("其他").font(.headline)) {
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image(systemName: "info.circle.fill").foregroundColor(.orange)
                            Text("關於我們")
                        }
                    }
                }
                
                Section(header: Text("升級進階版本").font(.headline)) {
                    HStack {
                        Image(systemName: "crown.fill").foregroundColor(.red)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text("獲得更多功能")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("升級到進階版本以解鎖")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("- 無廣告")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("- 更多功能")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button(action: {
                            print("click")
                        }) {
                            Text("升級")
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }.contentShape(Rectangle())
                    }
                    .padding()
                }
            
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("設定")
        }
    }
}

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("appIcon") // 假设您的应用图标名为"appIcon"
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(20)
                .shadow(radius: 10)

            Text("Macau Easy Pass")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("版本：1.0.0")
                .font(.subheadline)

            Spacer().frame(height: 20)

            Text("感謝您選擇我們的應用程式。我們致力於為您提供最佳的用戶體驗。如果您有任何建議或問題，請隨時與我們聯繫。")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer().frame(height: 20)

            Button(action: {
                // 这里可以添加联系我们的功能，例如打开一个邮件链接或跳转到一个反馈页面
            }) {
                Text("聯系我們")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 40)
                    .background(Color.blue)
                    .cornerRadius(30)
            }

            Spacer()

        }
        .padding()
        .navigationBarTitle("關於我們", displayMode: .inline)
    }
}

#Preview {
    SettingView()
}
