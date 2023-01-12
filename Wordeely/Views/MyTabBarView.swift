//
//  MyTabBarView.swift
//  Wordeely
//
//  Created by Liam Horch on 1/10/23.
//

import SwiftUI

struct MyTabBarView: View {
    @EnvironmentObject var game: GameController
    @Binding var showSideBar: Bool
    
    var body: some View {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct MyTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabBarView(showSideBar: .constant(false)).environmentObject(GameController())
    }
}
