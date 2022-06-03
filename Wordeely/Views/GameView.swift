//
//  GameView.swift
//  Wordeely
//
//  Created by Liam Horch on 5/31/22.
//

import SwiftUI

struct GameView: View {
    @Binding var guesses: [Guess]
    
    var body: some View {
        VStack {
            GuessesView(guesses: $guesses)
            KeyboardView(guesses: $guesses)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(guesses: .constant([Guess(text: "TESTS")]))
    }
}
