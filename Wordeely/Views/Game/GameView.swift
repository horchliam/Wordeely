//
//  GameView.swift
//  Wordeely
//
//  Created by Liam Horch on 5/31/22.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: GameController
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 5) {
            GuessesView().environmentObject(game)
                .padding(10)
            MinimalistKeyboardView().environmentObject(game)
            extraButtonsView
        }
        .padding(.bottom, 10)
    }
}

extension GameView {
    var extraButtonsView: some View {
        Group {
            if(game.showHint || game.showSubmit) {
                HStack {
                    HStack {
                        ExtraButton(text: "?", ratio: 1) {
                            game.revealLetter()
                        }
                        .opacity(game.showHint ? (game.hintCount == 0 ? 0.5 : 1) : 0)
                        ExtraButton(ratio: 1)
                            .hidden()
                        ExtraButton(ratio: 1)
                            .hidden()
                    }
                    
                    ExtraButton(text: "->", ratio: 3) {
                        game.submitPressed()
                    }
                    .opacity(game.showSubmit ? 1 : 0)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(GameController())
    }
}
