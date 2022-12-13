//
//  MainView.swift
//  Wordeely
//
//  Created by Liam Horch on 6/20/22.
//

import SwiftUI

enum ViewType {
    case Main, HowTo
}

struct MainView: View {
    @EnvironmentObject var game: GameController
    @State var showSideBar: Bool = false
    @State var curView: ViewType = .Main
    
    var body: some View {
        PopUpView(200, $game.win, {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight:.infinity)
                    .foregroundColor(Color.white)
                    .border(.black, width: 4)
                VStack {
                    Text("The word was \(game.solution)!")
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    // Spacer taking place of definition
                    Spacer()
                    Button(action: {game.dismissWinView()}) {
                        Text("Gotchya")
                            .frame(width: 200, height: 75)
                            .border(.black, width: 4)
                    }
                }
            }
        }) {
            VStack(spacing: 0) {
                MyTabBarView(showSideBar: $showSideBar, points: $game.score)
                    .frame(height: 50)
                SideBarView(sidebarWidth: 150, showSidebar: $showSideBar, sidebar:
                {
                    VStack(spacing: 10) {
                        ZStack {
                            Rectangle()
                                .aspectRatio(2, contentMode: .fit)
                                .foregroundColor(Color.white)
                                .border(.black, width: 2)
                            Button(action: {curView = .Main}) {
                                Text("Play")
                            }.buttonStyle(PlainButtonStyle())
                        }
                        ZStack {
                            Rectangle()
                                .aspectRatio(2, contentMode: .fit)
                                .foregroundColor(Color.white)
                                .border(.black, width: 2)
                            Button(action: {curView = .HowTo}) {
                                Text("How To")
                            }.buttonStyle(PlainButtonStyle())
                        }
                        Spacer()
                    }
                }, content: {
                    switch curView {
                    case .Main:
                        GameView().environmentObject(game)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .HowTo:
                        HowToView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(10)
                    }
                })
            }
        }.environmentObject(game)
    }
}

struct MyTabBarView: View {
    @Binding var showSideBar: Bool
    @Binding var points: Int
    
    var body: some View {
        HStack {
            Button(action: {showSideBar = !showSideBar }) {
                Text("=")
                    .font(.system(size: 25))
                    .frame(width: 50, height: 50)
                    .border(.black, width: 2)
            }.buttonStyle(PlainButtonStyle())
            Text("")
                .frame(maxWidth: .infinity)
            Text("Points: \(points)")
                .font(.system(size: 20))
                .frame(minWidth: 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showSideBar: true).environmentObject(GameController())
    }
}
