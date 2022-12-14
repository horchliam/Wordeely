//
//  TestView.swift
//  Wordeely
//
//  Created by Liam Horch on 6/11/22.
//

import SwiftUI

struct SideBarView<SidebarContent: View, Content: View>: View {
    let sidebarContent: SidebarContent
    let mainContent: Content
    let sidebarWidth: CGFloat
    @Binding var showSidebar: Bool
    
    init(sidebarWidth: CGFloat, showSidebar: Binding<Bool>, @ViewBuilder sidebar: ()->SidebarContent, @ViewBuilder content: ()->Content) {
        self.sidebarWidth = sidebarWidth
        self._showSidebar = showSidebar
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            mainContent
                .overlay(
                    Group {
                        if(showSidebar) {
                            MyColors.background
                                .ignoresSafeArea()
                                .opacity(0.5)
                                .onTapGesture {
                                    showSidebar = false
                                }
                        }
                    }
                        .animation(.default)
                )
            sidebarContent
                .frame(width: sidebarWidth, alignment: .center)
                .offset(x: showSidebar ? 10 : -1 * sidebarWidth, y: 0)
                .padding(.top, 10)
                .animation(.interpolatingSpring(mass: 1, stiffness: 350, damping: 20, initialVelocity: 10))
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView(sidebarWidth: 20, showSidebar: .constant(false), sidebar: { Text("Liam") }, content: { GameView().environmentObject(GameController()) })
    }
}
