//
//  PopUpView.swift
//  Wordeely
//
//  Created by Liam Horch on 6/23/22.
//

import SwiftUI

struct PopUpView<PopUpContent: View, MainContent: View>: View {
    let popUpContent: PopUpContent
    let mainContent: MainContent
    let popUpWidth: CGFloat
    @EnvironmentObject var game: GameController
    @Binding var showPopUp: Bool
    
    init(_ width: CGFloat, _ showPopUp: Binding<Bool>,@ViewBuilder _ popUp: ()->PopUpContent,
    @ViewBuilder _ mainContent: ()->MainContent) {
        self.popUpWidth = width
        self._showPopUp = showPopUp
        self.popUpContent = popUp()
        self.mainContent = mainContent()
    }
    
    var body: some View {
        ZStack {
            mainContent
                .overlay(
                    Group {
                        showPopUp ?
                        MyColors.background
                            .ignoresSafeArea()
                            .opacity(0.5)
                            .onTapGesture {
                                game.dismissWinView()
                            }
                        :
                        Color.clear
                            .ignoresSafeArea()
                            .opacity(0)
                            .onTapGesture {
                                // pointless
                                self.showPopUp = false
                            }
                    }
                        .animation(Animation.easeInOut.speed(2))
                )
            popUpContent
                .frame(width: popUpWidth, height: popUpWidth * 1.5, alignment: .center)
                .offset(x: showPopUp ? 0 : -2 * popUpWidth, y: 0)
                .animation(Animation.easeInOut.speed(1))
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(200, .constant(true), {Text("Pop up")}, {Text("Normal View")})
    }
}
