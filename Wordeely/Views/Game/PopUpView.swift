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
                        if(showPopUp) {
                            MyColors.background
                                .ignoresSafeArea()
                                .opacity(0.5)
                                .onTapGesture {
                                    game.dismissWinView()
                                }
                                .animation(.default)
                        }
                    }
                )
            popUpContent
                .frame(width: popUpWidth, height: popUpWidth, alignment: .center)
                .cornerRadius(15)
                .scaleEffect(showPopUp ? 1 : 0)
                .animation(.interpolatingSpring(mass: 1, stiffness: 350, damping: 20, initialVelocity: 10))
                .opacity(showPopUp ? 1 : 0) // Disable if not shown
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(200, .constant(true), {Text("Pop up")}, {Text("Normal View")})
    }
}
