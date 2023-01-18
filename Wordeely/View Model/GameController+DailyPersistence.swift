//
//  GameController+DailyPersistence.swift
//  Wordeely
//
//  Created by Liam Horch on 1/16/23.
//

import Foundation

struct DailyGameSession: Codable {
    let solution: String
    
    let hintCount: Int
    
    let scores: [DailyGameScoreRow]
    let letters: [String]
    let keyboard: [String]
    
    let sort: Bool
}

struct DailyGameScoreRow: Codable {
    let x: Int?
    let y: Int?
}

extension GameController {
    func saveDailySession() {
        let temp = self.letters.map{ $0.compactMap{ $0 }}
        let newLetters = temp.map{ String($0) }
        let newKeyboard = self.scrambledLetters.map{ String($0) }
        let newScores = self.scores.map{ DailyGameScoreRow(x: $0.0, y: $0.1) }
        let toSave = DailyGameSession(solution: self.dailySolution, hintCount: self.hintCount,
                                      scores: newScores, letters: newLetters, keyboard: newKeyboard, sort: self.sortLetters)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(toSave)
            UserDefaults.standard.set(data, forKey: "DailyGameSession")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func getDailySession() -> DailyGameSession? {
        if let data = UserDefaults.standard.data(forKey: "DailyGameSession") {
            do {
                let decoder = JSONDecoder()
                let dailyGameSession = try decoder.decode(DailyGameSession.self, from: data)
                return dailyGameSession
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return nil
    }
    
    func loadDailySession(_ toLoad: DailyGameSession) {
        solution = toLoad.solution
        if(sortLetters) {
            let temp = toLoad.keyboard.compactMap{ Array($0) }.joined()
            let other = temp.sorted()
            scrambledLetters = formatArray(other)
        } else {
            if(toLoad.sort) {
                let temp = toLoad.keyboard.compactMap{ Array($0) }.joined()
                let other = temp.shuffled()
                scrambledLetters = formatArray(other)
                saveDailySession()
            } else {
                scrambledLetters = toLoad.keyboard.map{ Array($0) }
            }
        }
        print("The word is \(solution)")
        editable = (toLoad.letters.last ?? "") != toLoad.solution
        row = toLoad.letters.count - 1
        col = editable ? 0 : 5
        letters = toLoad.letters.map{
            if $0 != "" {
                return Array($0)
            } else {
                return Array.init(repeating: nil, count: 5)
            }
        }
        scores = toLoad.scores.map{ ($0.x, $0.y) }
        opacity = Array.init(repeating: 1.0, count: toLoad.letters.count)
        hintCount = toLoad.hintCount
    }
    
}
