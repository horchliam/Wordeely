//
//  MainView.swift
//  Wordeely
//
//  Created by Liam Horch on 6/20/22.
//

import SwiftUI

enum ViewType: String, CaseIterable {
    case Main = "Play"
    case HowTo = "How To"
//    case Debug = "Debug"
}

struct MainView: View {
    @EnvironmentObject var game: GameController
    @State var curView: ViewType = .Main
    
    var body: some View {
        PopUpView(200, $game.win, {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(MyColors.text ,style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .background(MyColors.background)
                VStack {
                        Text("The word was \(game.solution)!")
                            .font(.custom("ChalkboardSE-Light", size: 20))
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(MyColors.text)
                            .padding(20)
                        Spacer()
                        Button(action: {
                            game.dismissWinView()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .padding(20)
                                    .foregroundColor(MyColors.primary)
                                    .cornerRadius(15)
                                    .shadow(color: .gray, radius: 0, x: 2, y: 2)
                                Text("Next Word")
                                    .font(.custom("ChalkboardSE-Light", size: 20))
                                    .foregroundColor(MyColors.text)
                            }
                        }
                }
            }
        }) {
            VStack(spacing: 0) {
                SideBarView(sidebarWidth: 150, showSidebar: $game.showSidebar, sidebar:
                {
                    VStack(spacing: 10) {
                        ForEach(ViewType.allCases, id:\.self) { value in
                            Button(action: {
                                curView = value
                                game.showSidebar = false
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .aspectRatio(2, contentMode: .fit)
                                        .foregroundColor(MyColors.primary)
                                    Text(value.rawValue)
                                        .font(.custom("ChalkboardSE-Light", size: 20))
                                        .foregroundColor(MyColors.text)
                                }
                            }.buttonStyle(PlainButtonStyle())
                        }
                        Spacer()
                    }
                }, content: {
                    VStack(spacing: 0) {
                        MyTabBarView(showSideBar: $game.showSidebar, points: $game.score)
                            .environmentObject(game)
                            .frame(height: 50)
                        switch curView {
                        case .Main:
                            GameView().environmentObject(game)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        case .HowTo:
                            HowToView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(10)
    //                    case .Debug:
    //                        DebugView().environmentObject(game)
    //                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                })
            }
        }.environmentObject(game)
    }
}

struct MyTabBarView: View {
    @EnvironmentObject var game: GameController
    @Binding var showSideBar: Bool
    @Binding var points: Int
    
    var body: some View {
        HStack {
            Button(action: {
                game.showSidebar = true
            }) {
                Circle()
                    .frame(width: 35, height: 35)
                    .foregroundColor(MyColors.secondary)
                    .shadow(color: MyColors.shadow, radius: 0, x: 2, y: 2)
            }.buttonStyle(PlainButtonStyle())
            Text("")
                .frame(maxWidth: .infinity)
            Text("Points: \(points)")
                .font(.system(size: 20))
                .frame(minWidth: 100)
                .hidden()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(GameController())
    }
}
