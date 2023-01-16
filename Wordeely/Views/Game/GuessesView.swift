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
                        .opacity(game.opacity[i])
                        .onAppear {
                            withAnimation(.default) {
                                game.opacity[i] = 1.0
                            }
                        }
                }
                .onChange(of: game.letters.count) { _ in
                    withAnimation {
                        value.scrollTo(game.letters.count - 1)
                    }
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
            filledCell
                .scaleEffect((letter == nil) ? 0 : 1)
                .animation(.interpolatingSpring(mass: 1, stiffness: 350, damping: (letter == nil) ? 50 : 20, initialVelocity: 10), value: letter)
            Group {
                letter == nil ?
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(MyColors.text, style: StrokeStyle(lineWidth: 1, dash: [5]))
                : nil
            }
        }
    }
}

extension GuessLetterCell {
    var filledCell: some View {
        ZStack {
            Rectangle()
                .modifier(RoundedButton())
            Text(String(letter ?? " "))
                .font(.custom("ChalkboardSE-Light", size: 18))
                .foregroundColor(MyColors.text)
        }
    }
}

struct GuessAnswerCell: View {
    var score: (Int?, Int?)
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                GuessAnswerCellNumber(score: score.0)
                Spacer()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
            }
            HStack{
                Spacer()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                GuessAnswerCellNumber(score: score.1)
            }
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .foregroundColor(Color.clear)
    }
}

struct GuessAnswerCellNumber: View {
    var score: Int?
    
    var body: some View {
        ZStack {
            Rectangle()
                .modifier(RoundedButton())
            Text(score != nil ? "\(score!)" : "")
                .font(.custom("ChalkboardSE-Light", size: 16))
                .foregroundColor(MyColors.text)
        }
        .scaleEffect((score == nil) ? 0 : 1)
        .animation(.interpolatingSpring(mass: 1, stiffness: 350, damping: 20, initialVelocity: 10), value: score)
    }
}

struct GuessRow: View {
    var curRow: Int
    @EnvironmentObject var game: GameController
    
    var body: some View {
        HStack {
            ForEach(0..<5) { i in
                (curRow < game.scores.count) ?
                GuessLetterCell(letter: game.letters[curRow][i])
                :
                GuessLetterCell(letter: nil)
            }
            (curRow < game.scores.count) ?
            GuessAnswerCell(score: (game.scores[curRow])) :
            GuessAnswerCell(score: (nil, nil))
        }
        .frame(maxWidth: 600)
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
