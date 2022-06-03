//
//  GuessesView.swift
//  Wordeely
//
//  Created by Liam Horch on 5/31/22.
//

import SwiftUI

struct GuessesView: View {
    @Binding var guesses: [Guess]

    var body: some View {
        List(guesses) {
            guess in GuessRow(guess: guess)
        }
    }
}

struct GuessRow: View {
    var guess: Guess
    var body: some View {
        HStack {
            ForEach(Array(guess.text), id: \.self) { letter in
                GuessCell(letter: String(letter))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct GuessCell: View {
    var letter: String
    var body: some View {
        Text(letter)
            .padding(10)
            .foregroundColor(.black)
            .font(.title)
            .border(Color.black, width: 5)
            .cornerRadius(10)
    }
}


struct GuessesView_Previews: PreviewProvider {
    static var previews: some View {
        GuessesView(guesses: .constant([Guess(text: "TESTS")]))
    }
}
