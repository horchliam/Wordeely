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
                        showSidebar ?
                        Color.white
                            .ignoresSafeArea()
                            .opacity(0.5)
                            .onTapGesture {
                                showSidebar = false
                            }
                        :
                        Color.clear
                            .ignoresSafeArea()
                            .opacity(0)
                            .onTapGesture {
                                showSidebar = false
                            }
                    }
                        .animation(Animation.easeInOut.speed(2))
                )
            sidebarContent
                .frame(width: sidebarWidth, alignment: .center)
                .offset(x: showSidebar ? 10 : -1 * sidebarWidth, y: 0)
                .animation(Animation.easeInOut.speed(1))
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView(sidebarWidth: 20, showSidebar: .constant(false), sidebar: { Text("Liam") }, content: { GameView().environmentObject(GameController()) })
    }
}
