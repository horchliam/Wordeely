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
            filledCell
                .scaleEffect((letter == nil) ? 0 : 1)
                .animation(.interpolatingSpring(mass: 1, stiffness: 350, damping: 20, initialVelocity: 10), value: letter)
            Group {
                letter == nil ?
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                : nil
            }
        }
    }
}

extension GuessLetterCell {
    var filledCell: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
//<<<<<<< HEAD
                .foregroundColor(MyColors.primary)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 0, x: 2, y: 2)
//=======
//                .foregroundColor((letter == nil) ? Color.clear : MyColors.primary)
//                .cornerRadius(10)
//                .shadow(color: (letter == nil) ? .clear : MyColors.shadow, radius: 0, x: 2, y: 2)
//                .overlay(
//                    letter == nil ?
//                    RoundedRectangle(cornerRadius: 10)
//                        .strokeBorder(MyColors.text, style: StrokeStyle(lineWidth: 1, dash: [5]))
//                    : nil
//                )
//>>>>>>> main
            Text(String(letter ?? " "))
                .font(.custom("ChalkboardSE-Light", size: 15))
                .foregroundColor(MyColors.text)
        }
    }
}

struct GuessAnswerCell: View {
    var score: (Int?, Int?)
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundColor(MyColors.primary)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 0, x: 2, y: 2)
//=======
//                        .foregroundColor((score.0 == nil) ? Color.clear : MyColors.primary)
//                        .cornerRadius(10)
//                        .shadow(color: (score.0 == nil) ? .clear : MyColors.shadow, radius: 0, x: 2, y: 2)
//>>>>>>> main
                    Text(score.0 != nil ? "\(score.0!)" : "")
                        .font(.custom("ChalkboardSE-Light", size: 15))
                        .foregroundColor(MyColors.text)
                }
                Spacer()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
            }
            .scaleEffect((score.0 == nil) ? 0 : 1)
            .animation(.interpolatingSpring(mass: 1, stiffness: 350, damping: 20, initialVelocity: 10), value: score.0)
            HStack{
                Spacer()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundColor(MyColors.primary)
                        .cornerRadius(10)
                        .shadow(color: MyColors.shadow, radius: 0, x: 2, y: 2)
//=======
//                        .foregroundColor((score.0 == nil) ? Color.clear : MyColors.primary)
//                        .cornerRadius(10)
//                        .shadow(color: (score.0 == nil) ? .clear : MyColors.shadow, radius: 0, x: 2, y: 2)
//>>>>>>> main
                    Text(score.1 != nil ? "\(score.1!)" : "")
                        .font(.custom("ChalkboardSE-Light", size: 15))
                        .foregroundColor(MyColors.text)
                }
            }
            .scaleEffect((score.1 == nil) ? 0 : 1)
            .animation(.interpolatingSpring(mass: 1, stiffness: 350, damping: 20, initialVelocity: 10), value: score.1)
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .foregroundColor(Color.clear)
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
                    .animation(.default, value: game.letters.count)
                :
                GuessLetterCell(letter: nil)
                    .animation(.default, value: game.letters.count)
            }
            (curRow < game.scores.count) ?
            GuessAnswerCell(score: (game.scores[curRow])) :
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
