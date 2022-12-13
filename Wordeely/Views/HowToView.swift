//
//  HowToView.swift
//  Wordeely
//
//  Created by Liam Horch on 6/22/22.
//

import SwiftUI

struct HowToView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Rules")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                Text("Guess the Wordeely in as many tries as you need.")
                Text("A guess can be anything, but the answer is a valid word.")
                Text("Each guess produces two numbers.")
                Text("The first number is how many letters are in the word.")
                Text("The second number is how many letters are in the correct spot in the word.")
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Examples")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                Text("Let's say the word is \"Happy\"")
                HStack {
                    GuessLetterCell(letter: "H")
                    GuessLetterCell(letter: "A")
                    GuessLetterCell(letter: "H")
                    GuessLetterCell(letter: "Y")
                    GuessLetterCell(letter: "Z")
                    GuessAnswerCell(score: (3, 2))
                }
                Text("The first 2 letters H and A are in the word and the correct spot so the second number is a 2. The Y is in the word but not the correct spot so it only contributes to the first number, H + A + Y = 3")
            }
            // Let the user guess a word and see how the numbers compare to Happy?
            // Push everything up
            Spacer()
        }
    }
}

struct HowToView_Previews: PreviewProvider {
    static var previews: some View {
        HowToView()
    }
}
