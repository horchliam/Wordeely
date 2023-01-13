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
        VStack {
            keyboardView
        }
    }
}

extension MinimalistKeyboardView {
    var keyboardView: some View {
        VStack {
            ForEach(game.scrambledLetters, id:\.self) { row in
                HStack {
                    ForEach(row, id:\.self) { letter in
                        Button(action: { game.keyPressed(letter ?? " ")}) {
                            ZStack {
                                Rectangle()
                                    .modifier(RoundedButton())
                                Text(String(letter ?? " "))
                                    .font(.custom("ChalkboardSE-Light", size: 15))
                                    .foregroundColor(MyColors.text)
                            }
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
            }
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(MyColors.text ,style: StrokeStyle(lineWidth: 1, dash: [5]))
        )
        .padding(.horizontal, 10)
    }
}

struct ExtraButton: View {
    var text: String = ""
    var ratio: Int = 1
    var action: () -> () = {}
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .modifier(RoundedButton(ratio: ratio))
                Text(text)
                    .font(.custom("ChalkboardSE-Light", size: 15))
                    .foregroundColor(MyColors.text)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct MinimalistKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        MinimalistKeyboardView().environmentObject(GameController())
    }
}
