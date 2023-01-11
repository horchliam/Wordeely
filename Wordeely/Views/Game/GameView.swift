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
                .padding(.bottom, 20)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(GameController())
    }
}
