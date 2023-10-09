// 在models/APIFetcher.swift中

import Foundation
import Combine

struct QuestionItem: Identifiable, Decodable {
    let id: UUID
    let type: String
    let Question: String
    let Options: [String]
    let Answer: String
    let Explain: String
}

class APIFetcher: ObservableObject {
    @Published var jsonData: [QuestionItem]? = nil
    @Published var error: Error? = nil


    func fetchDataForType(_ type: String) {
        switch type {
        case "law":
            fetchLegalQuestions()
        case "math":
            fetchMathQuestions()
        case "logic":
            fetchLogicQuestions()
        case "computer":
            fetchComputerQuestions()
        case "reading":
            fetchReadingQuestions()
        case "60_MockTest":
            fetchMockTest(mode: 60)
        case "20_MockTest":
            fetchMockTest(mode: 20)
        default:
            print("不支援的問題類型")
        }
    }
    
    private func fetchLogicQuestions() {
        fetchData(endpoint: "/fetchLogicData")
    }
    
    private func fetchReadingQuestions() {
        fetchData(endpoint: "/fetchReadingData")
    }
    
    private func fetchComputerQuestions() {
        fetchData(endpoint: "/fetchComputerData")
    }

    private func fetchLegalQuestions() {
        fetchData(endpoint: "/fetchdata")
    }

    private func fetchMathQuestions() {
        fetchData(endpoint: "/fetchMathData")
    }

    private func fetchMockTest(mode: Int) {
        // 使用DispatchGroup來同步多個非同步請求
        let group = DispatchGroup()
        var combinedData: [QuestionItem] = []

        // 獲取法例題
        group.enter()
        fetchMockData(endpoint: "/fetchdata") { legalQuestions in
            if mode == 20{
                combinedData.append(contentsOf: legalQuestions.shuffled().prefix(10))
            }else {
                combinedData.append(contentsOf: legalQuestions.shuffled().prefix(20))
            }
            group.leave()
        }

        // 獲取數學題
        group.enter()
        fetchMockData(endpoint: "/fetchMathData") { mathQuestions in
            if mode == 20{
                combinedData.append(contentsOf: mathQuestions.shuffled().prefix(2))
            }else {
                combinedData.append(contentsOf: mathQuestions.shuffled().prefix(15))
            }
            group.leave()
        }

        // 獲取計算機題
        group.enter()
        fetchMockData(endpoint: "/fetchComputerData") { computerQuestions in
            if mode == 20{
                combinedData.append(contentsOf: computerQuestions.shuffled().prefix(2))
            }else {
                combinedData.append(contentsOf: computerQuestions.shuffled().prefix(5))
            }
            group.leave()
        }
        
        // 獲取理解題
        group.enter()
        fetchMockData(endpoint: "/fetchReadingData") { readingQuestions in
            if mode == 20{
                combinedData.append(contentsOf: readingQuestions.shuffled().prefix(3))
            }else {
                combinedData.append(contentsOf: readingQuestions.shuffled().prefix(5))
            }
            group.leave()
        }

        // 獲取邏輯題
        group.enter()
        fetchMockData(endpoint: "/fetchLogicData") { logicQuestions in
            if mode == 20{
                combinedData.append(contentsOf: logicQuestions.shuffled().prefix(3))
            }else {
                combinedData.append(contentsOf: logicQuestions.shuffled().prefix(15))
            }
            group.leave()
        }
        

        // 確保所有請求都已完成
        group.notify(queue: .main) {
            self.jsonData = combinedData
        }
        
    }
    
    private func fetchMockData(endpoint: String, completion: (([QuestionItem]) -> Void)? = nil) {
        let baseApiUrl = "https://10tkybn5ic.execute-api.ap-northeast-1.amazonaws.com/prod"
        guard let url = URL(string: baseApiUrl + endpoint) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let questions = try decoder.decode([QuestionItem].self, from: data)
                    completion?(questions)
                } catch let parseError {
                    print("解碼錯誤: \(parseError.localizedDescription)")
                    print(parseError)
                    DispatchQueue.main.async {
                        self.error = parseError
                    }
                }
            } else if let error = error {
                print("網絡錯誤: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }.resume()
    }

    private func fetchData(endpoint: String, completion: (([QuestionItem]) -> Void)? = nil) {
        let baseApiUrl = "https://10tkybn5ic.execute-api.ap-northeast-1.amazonaws.com/prod"
        guard let url = URL(string: baseApiUrl + endpoint) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let questions = try decoder.decode([QuestionItem].self, from: data)
                    completion?(questions)
                    self.jsonData = questions.shuffled()
                } catch let parseError {
                    print("解碼錯誤: \(parseError.localizedDescription)")
                    print(parseError)
                    DispatchQueue.main.async {
                        self.error = parseError
                    }
                }
            } else if let error = error {
                print("網絡錯誤: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }.resume()
    }
    func freeData() {
        self.jsonData = nil
    }
}
