//
//  DataController.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 27/03/21.
//

import Foundation

class DataController: ObservableObject {
    static var shared = DataController()
    @Published var score = 0
    @Published var timeRemaining = 10
//    @Published var pastScores: [Int] = []
}
