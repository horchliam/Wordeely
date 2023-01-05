//
//  MinimalistKeyboardView.swift
//  Wordeely
//
//  Created by Liam Horch on 1/5/23.
//

import SwiftUI

struct MinimalistKeyboardView: View {
    @EnvironmentObject var game: GameController
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(game.scrambledLetters, id:\.self) { row in
                    HStack {
                        ForEach(row, id:\.self) { letter in
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: .infinity)
                                    .aspectRatio(1, contentMode: .fit)
                                    .foregroundColor(MyColors.primary1)
                                    .cornerRadius(15)
                                    .shadow(color: .gray, radius: 0, x: 2, y: 2)
                                Button(action: { game.keyPressed(letter)}) {
                                    Text(String(letter))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
        )
        .padding(10)
    }
}

struct MinimalistKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        MinimalistKeyboardView().environmentObject(GameController())
    }
}
