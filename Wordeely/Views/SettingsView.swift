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
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Settings")
                        .foregroundColor(MyColors.text)
                        .font(.custom("ChalkboardSE-Bold", size: 25))
                    Group {
                        
                        Button(action: {
                            game.toggleHintButton()
                        }) {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(MyColors.primary)
                                        .frame(width:30, height:30)
                                    Text(game.showHint ? "X" : "")
                                }
                                Text("Show hint button")
                            }
                        }
                        .buttonStyle(ScaleButtonStyle())
                        
                        Button(action: {
                            game.toggleSubmitButton()
                        }) {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(MyColors.primary)
                                        .frame(width:30, height:30)
                                    Text(game.showSubmit ? "X" : "")
                                }
                                Text("Show submit button")
                            }
                        }
                        .buttonStyle(ScaleButtonStyle())
                        
                        Button(action: {
                            game.toggleOrderKeyboard()
                        }) {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(MyColors.primary)
                                        .frame(width:30, height:30)
                                    Text(game.sortLetters ? "X" : "")
                                }
                                Text("Alphabetically order keyboard")
                            }
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    .font(.custom("ChalkboardSE-Light", size: 15))
                    .foregroundColor(MyColors.text)
                }
                Spacer()
            }
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(MyColors.text ,style: StrokeStyle(lineWidth: 1, dash: [5]))
            )
            
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
