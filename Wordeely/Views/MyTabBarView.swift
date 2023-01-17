//
//  MyTabBarView.swift
//  Wordeely
//
//  Created by Liam Horch on 1/10/23.
//

import SwiftUI

struct MyTabBarView: View {
    @EnvironmentObject var game: GameController
    @State var headerOpacity: Double = 1.0
    @Binding var showSideBar: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                Button(action: {
                    game.showSidebar = true
                }) {
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundColor(MyColors.secondary)
                        .shadow(color: MyColors.shadow, radius: 0, x: 2, y: 2)
                }.buttonStyle(ScaleButtonStyle())
                Spacer()
            }
            .frame(maxWidth: .infinity)
            HStack {
                Spacer()
                Text(game.difficulty.rawValue)
                    .font(.custom("ChalkboardSE-Light", size: 20))
                    .foregroundColor(MyColors.text)
                    .opacity(game.headerOpacity)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            HStack{
                Text("")
            }
                .frame(maxWidth: .infinity)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .onAppear {
            withAnimation(.default.delay(1.0).speed(0.5)) {
                game.headerOpacity = 0.0
            }
        }
    }
}

struct MyTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabBarView(showSideBar: .constant(false)).environmentObject(GameController())
    }
}
