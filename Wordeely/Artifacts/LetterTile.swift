//
//  LetterTile.swift
//  Wordeely
//
//  Created by Liam Horch on 6/7/22.
//

import SwiftUI

enum LetterEvaluation {
    case notIncluded // not included in the solution word
    case included    // included, but wrong position
    case match       // included and correct position
}

struct LetterTile: View {
    let letter: Character?
    let evaluation: LetterEvaluation?
    
    init(_ letter: Character?, _ evaluation: LetterEvaluation?) {
        self.letter = letter
        self.evaluation = evaluation
    }
    
    var body: some View { ZStack() {
        Rectangle()
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(self.evaluation?.color ?? Color.white)
            .border(.black, width: 4)
            if let letter = letter {
                Text(String(letter))
                    .font(.system(size: 36, weight: .bold, design: .rounded))
            }
        }
    }
}

private extension LetterEvaluation {
    var color: Color {
        switch self {
        case .notIncluded:
            return Color(.systemGray5)
        case .included:
            return Color(.systemYellow)
        case .match:
            return Color(.systemGreen)
        }
    }
}

struct LetterTile_Previews: PreviewProvider {
    static var previews: some View {
        LetterTile("A", .notIncluded)
    }
}
