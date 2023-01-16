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
struct WordeelyResponse: Decodable {
    let word: String
}

class GameController: ObservableObject {
    let width: Int
    var height: Int
    
    @Published var row: Int = 0
    var col: Int = 0

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
    
    private var editable: Bool = true
    
    @Published var showSidebar: Bool = false
    // Array of tuples representing how correct each guess was
    @Published var scores: [(Int?, Int?)] = [(Int?, Int?)]()
    // An array of guesses
    @Published var letters: [[Character?]]
    @Published var opacity: [Double]
    // Did ya win?
    @Published var win: Bool = false
    @Published var score: Int = UserDefaults.standard.integer(forKey: "Score")
    @Published var headerOpacity: Double = 1.0
    // Dummy place holder value
    
    // Bools for extra buttons
    @Published var showSubmit: Bool = UserDefaults.standard.bool(forKey: "ShowSubmit")
    @Published var showHint: Bool = UserDefaults.standard.bool(forKey: "ShowHint")
    var hintCount: Int = 2
    
    var solution: String = "HAPPY"
    var dailySolution: String = "HAPPY"
    @Published var scrambledLetters: [[Character?]] = [[Character?]]()
    var difficulty: Difficulty = Difficulty(rawValue: UserDefaults.standard.string(forKey: "Difficulty") ?? "") ?? .Hard
    var scrambleLength: Int {
        switch difficulty {
        case .Easy:
            return 12
        case .Medium, .Daily:
            return 18
        case .Hard:
            return 24
        }
    }
    
    init(width: Int = 5, height: Int = 1) {
        self.width = width
        self.height = height
        letters = Array(
            repeating: .init(repeating: nil, count: width),
            count: height
        )
        opacity = [0.0]
        scores = [(nil, nil)]
        getWord()
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
    }
    
    // Pick a new random word and reset the guesses
    func newGame() {
        if(difficulty == .Daily) {
            solution = dailySolution
        } else {
            solution = words.randomElement()!.lowercased()
        }
        let temp = scrambleLetters()
        scrambledLetters = formatArray(temp)
        print("The word is \(solution)")
        row = 0
        col = 0
        letters = Array(
            repeating: .init(repeating: nil, count: width),
            count: height
        )
        scores = [(nil, nil)]
        opacity = [1.0]
        hintCount = 2
        editable = true
    }
    
    func formatArray(_ input: [Character?]) -> [[Character?]] {
        var res = [[Character?]]()
        var temp = [Character?]()
        
        for i in 0..<input.count/6 {
            temp = [Character?]()
            for j in 0..<6 {
                temp.append(input[i*6 + j])
            }
            res.append(temp)
        }
        
        return res
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
        if shouldAutoSubmit() && col == 5 {
            submitPressed()
        }
    }
    
    func submitPressed() {
        guard col == 5 else {
            // Prompt user to put in 5 characters maybe
            return
        }
        editable = false
        
        if(scores[row].0 == 5) {
            self.win = true
            return
        }
        
        if(!evaluate()) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                self.row = self.row + 1
                let rowToAdd: [Character?] = .init(repeating: nil, count: self.width)
                self.opacity.append(0.0)
                self.letters.append(rowToAdd)
                self.scores.append((nil, nil))
                self.col = 0
                self.editable = true
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                self.vibrate(type: .success)
                self.win = true
                self.editable = (self.difficulty != .Daily)
            }
        }
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.scores[self.row].0 = toAddToScores.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.scores[self.row].1 = toAddToScores.1
        }
        
        if toAddToScores.1 == 5 {
            return true
        }
        return false
    }
    
    // Delete the most recent letter from the current guess
    func backPressed() {
        guard col > 0  && editable else {
            return
        }
        
        col = col - 1
        letters[row][col] = nil
    }
    
    func toggleSubmitButton() {
        showSubmit = !showSubmit
        UserDefaults.standard.set(showSubmit, forKey: "ShowSubmit")
    }
    
    func shouldAutoSubmit() -> Bool {
        !showSubmit
    }
    
    func toggleHintButton() {
        showHint = !showHint
        UserDefaults.standard.set(showSubmit, forKey: "ShowSubmit")
    }
    
    func revealLetter() {
        guard col < 5 && hintCount > 0 else {
            return
        }
            
        hintCount -= 1
        let i = col
        let letter = solution[solution.index(solution.startIndex, offsetBy: i)]
        keyPressed(letter)
    }
    
    // Daily Game Controller stuff
    func getWord() {
        guard let url = URL(string: "https://blogdeliam.com/api/Password12/wordeely") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let theWord = try JSONDecoder().decode(WordeelyResponse.self, from: data)
                        print("Word from server: " + theWord.word)
                        self.setDailyWord(word: theWord.word)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
    func setDailyWord(word: String) {
        self.dailySolution = word
        newGame()
    }
}
