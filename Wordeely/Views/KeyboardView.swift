//
//  KeyboardView.swift
//  Wordeely
//
//  Created by Liam Horch on 5/31/22.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var game: GameController
    // Resets col and row upon revisiting the view, not desired
//    @State var row: Int = 0
//    @State var col: Int = 0
    
    var keys: [[KeyboardKey]] =
    [[KeyboardKey(letter: "Q"), KeyboardKey(letter: "W"), KeyboardKey(letter: "E"), KeyboardKey(letter: "R"), KeyboardKey(letter: "T"), KeyboardKey(letter: "Y"), KeyboardKey(letter: "U"), KeyboardKey(letter: "I"), KeyboardKey(letter: "O"), KeyboardKey(letter: "P")],
    [KeyboardKey(letter: "A"), KeyboardKey(letter: "S"), KeyboardKey(letter: "D"), KeyboardKey(letter: "F"), KeyboardKey(letter: "G"), KeyboardKey(letter: "H"), KeyboardKey(letter: "J"), KeyboardKey(letter: "K"), KeyboardKey(letter: "L")],
     [KeyboardKey(letter: "Z"), KeyboardKey(letter: "X"), KeyboardKey(letter: "C"), KeyboardKey(letter: "V"), KeyboardKey(letter: "B"), KeyboardKey(letter: "N"), KeyboardKey(letter: "M")]]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0...2, id: \.self) { i in
                HStack(spacing: 5) {
                    if(i == 2) {
                        Button(action: game.submitPressed) {
                            Text("Enter")
                                .aspectRatio(2, contentMode: .fit)
                                .padding(10)
                                .foregroundColor(.black)
                                .border(Color.black, width: 2)
                        }
                    }
                    ForEach(keys[i], id: \.id) { cur in
                        Button(action: {
                            game.keyPressed(cur.letter)
                        }) {
                            ZStack {
                                Text("X")
                                    .foregroundColor(.white)
                                    .aspectRatio(1, contentMode: .fit)
                                    .padding(11)
                                    .foregroundColor(.black)
                                    .border(Color.black, width: 2)
                                Text(String(cur.letter))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    if(i == 2) {
                        Button(action: game.backPressed) {
                            Text("Back")
                                .aspectRatio(2, contentMode: .fit)
                                .padding(11)
                                .foregroundColor(.black)
                                .border(Color.black, width: 2)
                        }
                    }
                }
            }
        }
    }
}

struct KeyKey: View {
    var char: Character
    
    var body: some View {
        ZStack {
            Rectangle()
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(Color.white)
                .border(.black, width: 4)
            Text(String(char))
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView().environmentObject(GameController())
    }
}
