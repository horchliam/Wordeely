//
//  KeyboardView.swift
//  Wordeely
//
//  Created by Liam Horch on 5/31/22.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var game: GameController
    
    var keys: [[KeyboardKey]] =
    [[KeyboardKey(letter: "Q"), KeyboardKey(letter: "W"), KeyboardKey(letter: "E"), KeyboardKey(letter: "R"), KeyboardKey(letter: "T"), KeyboardKey(letter: "Y"), KeyboardKey(letter: "U"), KeyboardKey(letter: "I"), KeyboardKey(letter: "O"), KeyboardKey(letter: "P")],
     [KeyboardKey(letter: "A"), KeyboardKey(letter: "S"), KeyboardKey(letter: "D"), KeyboardKey(letter: "F"), KeyboardKey(letter: "G"), KeyboardKey(letter: "H"), KeyboardKey(letter: "J"), KeyboardKey(letter: "K"), KeyboardKey(letter: "L")],
     [KeyboardKey(letter: "Z"), KeyboardKey(letter: "X"), KeyboardKey(letter: "C"), KeyboardKey(letter: "V"), KeyboardKey(letter: "B"), KeyboardKey(letter: "N"), KeyboardKey(letter: "M")]]
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(0...2, id: \.self) { i in
                HStack(alignment: .center, spacing: 2) {
                    ForEach(keys[i], id: \.id) { cur in
                        KeyboardKeyView(action: game.keyPressed, letter: cur.letter)
                    }
                }
            }
            actionButtons
        }
    }
}

extension KeyboardView {
    var actionButtons: some View {
        HStack {
            Spacer()
            Button(action: game.backPressed) {
                Text("Back")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 11)
                    .foregroundColor(.black)
                    .border(Color.black, width: 2)
            }
            Button(action: game.submitPressed) {
                Text("Enter")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 11)
                    .foregroundColor(.black)
                    .border(Color.black, width: 2)
            }
            Spacer()
        }
    }
}

struct KeyboardKeyView: View {
    let action: (Character) -> Void
    let letter: Character
    
    var body: some View {
        Button(action: { self.action(self.letter) }) {
            ZStack {
                Text("X")
                    .foregroundColor(.clear)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(13)
                    .foregroundColor(.black)
                    .border(Color.black, width: 2)
                Text(String(self.letter))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView().environmentObject(GameController())
    }
}
