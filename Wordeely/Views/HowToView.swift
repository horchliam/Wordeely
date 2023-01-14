//
//  HowToView.swift
//  Wordeely
//
//  Created by Liam Horch on 6/22/22.
//

import SwiftUI

struct HowToView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Rules")
                    .foregroundColor(MyColors.text)
                    .font(.custom("ChalkboardSE-Bold", size: 25))
                Group {
                    Text("A guess can be anything, but the answer is a valid word.")
                    Text("If you wish to backspace a letter, simply tap the unwanted letter's row.")
                    Text("Each guess produces two numbers.")
                    Text("The first number is how many letters are in the word.")
                    Text("The second number is how many letters are in the correct spot in the word.")
                }
                .font(.custom("ChalkboardSE-Light", size: 15))
                .foregroundColor(MyColors.text)
                .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(MyColors.text ,style: StrokeStyle(lineWidth: 1, dash: [5]))
            )
            VStack(alignment: .leading, spacing: 6) {
                Text("Example")
                    .foregroundColor(MyColors.text)
                    .font(.custom("ChalkboardSE-Bold", size: 25))
                Text("Let's say the word is \"happy\"")
                    .foregroundColor(MyColors.text)
                    .font(.custom("ChalkboardSE-Light", size: 15))
                HStack {
                    GuessLetterCell(letter: "h")
                    GuessLetterCell(letter: "a")
                    GuessLetterCell(letter: "h")
                    GuessLetterCell(letter: "y")
                    GuessLetterCell(letter: "z")
                    GuessAnswerCell(score: (3, 2))
                }
                Text("The first 2 letters h and a are in the word and the correct spot so the second number is a 2. The y is in the word but not the correct spot so it only contributes to the first number, h + a + y = 3")
                    .foregroundColor(MyColors.text)
                    .font(.custom("ChalkboardSE-Light", size: 15))
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(MyColors.text ,style: StrokeStyle(lineWidth: 1, dash: [5]))
            )
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
