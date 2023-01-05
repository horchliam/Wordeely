//
//  DebugView.swift
//  Wordeely
//
//  Created by Liam Horch on 1/4/23.
//

import SwiftUI

struct DebugView: View {
    var body: some View {
        VStack(spacing: 5) {
            GuessesView().environmentObject(GameController())
                .padding(10)
            DebugKeyboardView()
                .padding(.bottom, 40)
        }
    }
}

struct DebugKeyboardView: View {
    var letters: [[Character]] = [["a", "b", "c", "e", "f"], ["g", "h", "i", "j", "k"]]
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(letters, id:\.self) { row in
                    HStack {
                        ForEach(row, id:\.self) { letter in
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: .infinity)
                                    .aspectRatio(1, contentMode: .fit)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(15)
                                    .shadow(color: .gray, radius: 0, x: 2, y: 2)
                                Text(String(letter))
                            }
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(Color(hex: MyColors.lightBlue))
        .cornerRadius(15)
        .padding(20)
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
