//
//  SettingsView.swift
//  Wordeely
//
//  Created by Liam Horch on 1/13/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var game: GameController
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Settings")
                    .foregroundColor(MyColors.text)
                    .font(.custom("ChalkboardSE-Bold", size: 25))
                HStack {
                    Group {
                        Button(action: { game.toggleHintButton() }) {
                            Text("Hint Button")
                        }
                        Button(action: { game.toggleSubmitButton() }) {
                            Text("Submit Button")
                        }
                    }
                    .font(.custom("ChalkboardSE-Light", size: 15))
                    .foregroundColor(MyColors.text)
                    Spacer()
                }
            }
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(MyColors.text ,style: StrokeStyle(lineWidth: 1, dash: [5]))
            )
            .padding(.horizontal, 10)
            
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
