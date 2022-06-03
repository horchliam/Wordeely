//
//  KeyboardView.swift
//  Wordeely
//
//  Created by Liam Horch on 5/31/22.
//

import SwiftUI

struct KeyboardView: View {
    @Binding var guesses: [Guess]
    
    var keys: [[KeyboardKey]] =
    [[KeyboardKey(letter: "Q"), KeyboardKey(letter: "W"), KeyboardKey(letter: "E"), KeyboardKey(letter: "R"), KeyboardKey(letter: "T"), KeyboardKey(letter: "Y"), KeyboardKey(letter: "U"), KeyboardKey(letter: "I"), KeyboardKey(letter: "O"), KeyboardKey(letter: "P")],
    [KeyboardKey(letter: "A"), KeyboardKey(letter: "S"), KeyboardKey(letter: "D"), KeyboardKey(letter: "F"), KeyboardKey(letter: "G"), KeyboardKey(letter: "H"), KeyboardKey(letter: "J"), KeyboardKey(letter: "K"), KeyboardKey(letter: "L")],
     [KeyboardKey(letter: "Z"), KeyboardKey(letter: "X"), KeyboardKey(letter: "C"), KeyboardKey(letter: "V"), KeyboardKey(letter: "B"), KeyboardKey(letter: "N"), KeyboardKey(letter: "M")]]
    
    var body: some View {
        VStack {
            ForEach(0...2, id: \.self) { i in
                HStack {
                    ForEach(keys[i], id: \.id) { cur in
                        Button(action: {
                            guesses.append(Guess(text: cur.letter))
                        }) {
                            Text(cur.letter)
                        }
                            .padding(10)
                            .foregroundColor(.black)
                            .font(.title)
                            .border(Color.black, width: 5)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(guesses: .constant([Guess(text: "TESTS")]))
    }
}
