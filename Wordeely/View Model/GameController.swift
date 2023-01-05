//
//  GameController.swift
//  Wordeely
//
//  Created by Liam Horch on 6/8/22.
//

import Foundation
import UIKit
/* Game Structure Visualization...
 
 Guesses are stored in 'letters' array...
 [  [G,U,E,S,S],
    [O,T,H,E,R],
    [W,O,R,D,_] <- Current guess, col = 4 and row = 2
 ]
 
 Scores for each guess are stored in 'scores' array...
 [  (1,2),
    (3,3),
    There is nothing here yet, guess is in progress, has not been evaluated
 ]
 */
class GameController: ObservableObject {
    let width: Int
    var height: Int
    
    @Published var row: Int = 0
    private var col: Int = 0

    private var words: [String] {
        if let path = Bundle.main.path(forResource: "Words", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                return myStrings
            } catch {
                print(error)
            }
        }
        return ["HAPPY"]
    }
    @Published var showSidebar: Bool = false
    // Array of tuples representing how correct each guess was
    @Published var scores: [(Int?, Int?)] = [(Int?, Int?)]()
    // An array of guesses
    @Published var letters: [[Character?]]
    // Did ya win?
    @Published var win: Bool = false
    @Published var score: Int = UserDefaults.standard.integer(forKey: "Score")
    // Dummy place holder value
    var solution: String = "HAPPY"
    var scrambledLetters: [[Character?]] = [[Character?]]()
    let scrambleLength: Int = 18
    
    init(width: Int = 5, height: Int = 1) {
        self.width = width
        self.height = height
        letters = Array(
            repeating: .init(repeating: nil, count: width),
            count: height
        )
        scores = [(nil, nil)]
        newGame()
    }
    
    private func vibrate(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func dismissWinView() {
        win = false
        score = score + 100
        UserDefaults.standard.set(score, forKey: "Score")
        vibrate(type: .success)
        newGame()
    }
    // Pick a new random word and reset the guesses
    func newGame() {
        solution = words.randomElement()!.lowercased()
        let temp = scrambleLetters()
        scrambledLetters = [Array(temp[0..<scrambleLength/3]), Array(temp[scrambleLength/3..<2*scrambleLength/3]), Array(temp[2*scrambleLength/3..<scrambleLength])]
        print("The word is \(solution)")
        row = 0
        col = 0
        letters = Array(
            repeating: .init(repeating: nil, count: width),
            count: height
        )
        scores = [(nil, nil)]
    }
    // Scramble the possible letters to use
    func scrambleLetters() -> [Character?] {
        var result: [Character?] = Array(
            repeating: nil,
            count: scrambleLength
        )
        let cc: CharacterCollection = CharacterCollection()
        var index = Int.random(in: 0..<scrambleLength)
        for c in solution {
            if(cc.letters.contains(c)) {
                while(result[index] != nil) {
                    index = Int.random(in: 0..<scrambleLength)
                }
                result[index] = cc.pop(c: c)
            }
        }
        for i in 0..<result.count {
            if(result[i] == nil) {
                result[i] = cc.getRandom()
            }
        }
        
        return result
    }
    // Add the pressed letter to the current guess
    func keyPressed(_ letter: Character) {
        guard col < 5 else {
            return
        }
        
        letters[row][col] = letter
        col = col + 1
        if col == 5 {
            submitPressed()
        }
    }
    
    func submitPressed() {
        guard col == 5 else {
            // Prompt user to put in 5 characters maybe
            return
        }
        
        if(!evaluate()) {
            row = row + 1
            let rowToAdd: [Character?] = .init(repeating: nil, count: width)
            letters.append(rowToAdd)
            scores.append((nil, nil))
        } else {
            win = true
        }
        col = 0
    }
    // How correct was the word?
    func evaluate() -> Bool {
        var toAddToScores: (Int, Int) = (0, 0)
        var solArr: [Character?] = Array(solution)
        let guessArr: [Character] = letters[row].map { $0! }
        
        for i in 0..<solArr.count {
            if solArr[i] == guessArr[i] {
                toAddToScores.1 = toAddToScores.1 + 1
            }
        }
        
        for i in 0..<guessArr.count {
            let guessC: Character = guessArr[i]
            for j in 0..<solArr.count {
                if let c = solArr[j] {
                    if guessC == c {
                        toAddToScores.0 = toAddToScores.0 + 1
                        solArr[j] = nil
                        break
                    }
                }
            }
        }
        
        scores[row] = toAddToScores
        
        if toAddToScores.1 == 5 {
            return true
        }
        return false
    }
    // Delete the most recent letter from the current guess
    func backPressed() {
        guard col > 0 else {
            return
        }
        
        col = col - 1
        letters[row][col] = nil
    }
}
