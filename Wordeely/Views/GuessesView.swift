//
//  GuessesView.swift
//  Wordeely
//
//  Created by Liam Horch on 5/31/22.
//

import SwiftUI

struct GuessesView: View {
    @EnvironmentObject var game: GameController
    
    var body: some View {
        ScrollView {
            // Look up how this works lol
            // Answer from:
            // https://stackoverflow.com/questions/58376681/swiftui-automatically-scroll-to-bottom-in-scrollview-bottom-first
            ScrollViewReader { value in
                ForEach(0..<game.letters.count, id: \.self) { i in
                    GuessRow(curRow: i).environmentObject(game)
                }
                .onChange(of: game.letters.count) { _ in
                    value.scrollTo(game.letters.count - 1)
                }
            }
            .padding(5)
        }
    }
}

struct GuessLetterCell: View {
    var letter: Character?
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
            //                .cornerRadius(10)
            //                .border(.black, width: 2)
            Text(String(letter ?? " "))
        }
    }
}

struct GuessAnswerCell: View {
    var score: (Int?, Int?)
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(Color.white)
            Text(score.1 != nil ? "\(score.0!)/\(score.1!)" : "-/-")
                .font(.system(size: 25))
        }
    }
}

struct GuessRow: View {
    var curRow: Int
    @EnvironmentObject var game: GameController
    
    var body: some View {
        HStack {
            // These out of bounds checks are odd
            // I do not know what the issue is but it might be a concurrency thing
            ForEach(0..<5) { i in
                (curRow < game.scores.count) ?
                GuessLetterCell(letter: game.letters[curRow][i]) :
                GuessLetterCell(letter: nil)
            }
            (curRow < game.scores.count) ?
            GuessAnswerCell(score: game.scores[curRow]) :
            GuessAnswerCell(score: (nil, nil))
        }
    }
}

struct GuessesView_Previews: PreviewProvider {
    static var previews: some View {
        GuessesView().environmentObject(GameController())
    }
}
