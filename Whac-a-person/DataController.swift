//
//  DataController.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 28/03/21.
//

import Foundation
import SwiftUI

class DataController: ObservableObject {
    static var shared = DataController()
    @Published var pastScores: [Int] = []
    
    
    func saveScore(score: Int) {
        pastScores.append(score)
        saveData()
    }
    
    
    func resetPastScores() {
        pastScores = []
        saveData()
    }
    
    
    func saveData() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.pastScores) {
                UserDefaults.standard.setValue(encoded, forKey: "pastScores")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    
    func loadData() {
        DispatchQueue.global().async {
            if let data = UserDefaults.standard.data(forKey: "pastScores") {
                let decoder = JSONDecoder()
                if let jsonPastScores = try? decoder.decode([Int].self, from: data) {
                    DispatchQueue.main.async {
                        self.pastScores = jsonPastScores
                    }
                }
            }
        }
    }
}
