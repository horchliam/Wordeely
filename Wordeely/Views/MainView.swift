//
//  MainView.swift
//  Wordeely
//
//  Created by Liam Horch on 6/20/22.
//

import SwiftUI

enum ViewType: CaseIterable {
    case Main
    case HowTo
}

enum Difficulty: String, CaseIterable{
    case Easy = "Easy"
    case Medium = "Medium"
    case Hard = "Hard"
}

struct MainView: View {
    @EnvironmentObject var game: GameController
    @State var curView: ViewType = .Main
    @State var showSubTabBar: Bool = false
    
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
                                .shadow(color: MyColors.shadow, radius: 0, x: 2, y: 2)
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
                        Button(action: {
                            showSubTabBar = !showSubTabBar
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .aspectRatio(2, contentMode: .fit)
                                    .foregroundColor(MyColors.primary)
                                Text("Play")
                                    .font(.custom("ChalkboardSE-Light", size: 30))
                                    .minimumScaleFactor(0.5)
                                    .foregroundColor(MyColors.text)
                            }
                        }.buttonStyle(ScaleButtonStyle())
                        
                        if(showSubTabBar) {
                            VStack(spacing: 10) {
                                ForEach(Difficulty.allCases, id:\.self) { value in
                                    Button(action: {
                                        curView = .Main
                                        if(game.difficulty != value) {
                                            game.difficulty = value
                                            game.newGame()
                                        }
                                        game.showSidebar = false
                                        showSubTabBar = false
                                    }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 15)
                                                .foregroundColor(MyColors.primary)
                                            Text(value.rawValue)
                                                .font(.custom("ChalkboardSE-Light", size: 25))
                                                .minimumScaleFactor(0.5)
                                                .foregroundColor(MyColors.text)
                                        }
                                        .frame(maxHeight: .infinity)
                                    }
                                    .buttonStyle(ScaleButtonStyle())
                                }
                            }
                            .padding(.horizontal, 20)
                            .frame(height: 150)
                        }
                        
                        Button(action: {
                            curView = .HowTo
                            game.showSidebar = false
                            showSubTabBar = false
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .aspectRatio(2, contentMode: .fit)
                                    .foregroundColor(MyColors.primary)
                                Text("How To")
                                    .font(.custom("ChalkboardSE-Light", size: 30))
                                    .minimumScaleFactor(0.5)
                                    .foregroundColor(MyColors.text)
                            }
                        }.buttonStyle(ScaleButtonStyle())
                        Spacer()
                    }
                }, content: {
                    VStack(spacing: 0) {
                        MyTabBarView(showSideBar: $game.showSidebar)
                            .environmentObject(game)
                            .frame(height: 50)
                        HStack {
                            Spacer()
                            switch curView {
                            case .Main:
                                GameView().environmentObject(game)
                                    .frame(maxWidth: 600, maxHeight: .infinity)
                            case .HowTo:
                                HowToView()
                                    .frame(maxWidth: 600, maxHeight: .infinity)
                                    .padding(10)
                            }
                            Spacer()
                        }
                    }
                })
            }
        }.environmentObject(game)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(GameController())
    }
}
