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
                .foregroundColor((letter == nil) ? Color.clear : MyColors.primary1)
                .cornerRadius(10)
                .shadow(color: (letter == nil) ? .clear : .gray, radius: 0, x: 2, y: 2)
                .overlay(
                    letter == nil ?
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    : nil
                )
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
                .foregroundColor(Color.clear)
            Text(score.1 != nil ? "\(score.0!) \(score.1!)" : "")
                .font(.system(size: 25))
        }
    }
}

struct GuessRow: View {
    var curRow: Int
    @EnvironmentObject var game: GameController
    
    var body: some View {
        HStack {
            ForEach(0..<5) { i in
                (curRow < game.scores.count) ?
                GuessLetterCell(letter: game.letters[curRow][i]) :
                GuessLetterCell(letter: nil)
            }
            (curRow < game.scores.count) ?
            GuessAnswerCell(score: game.scores[curRow]) :
            GuessAnswerCell(score: (nil, nil))
        }
        .onTapGesture {
            game.backPressed()
        }
    }
}

struct GuessesView_Previews: PreviewProvider {
    static var previews: some View {
        GuessesView().environmentObject(GameController())
    }
}
