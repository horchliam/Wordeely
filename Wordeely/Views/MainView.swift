//
//  MainView.swift
//  Wordeely
//
//  Created by Liam Horch on 6/20/22.
//

import SwiftUI

enum ViewType: String, CaseIterable {
    case Main = "Play"
    case HowTo = "HowTo"
    case Settings = "Settings"
}

enum Difficulty: String, CaseIterable{
    case Easy = "Easy"
    case Medium = "Medium"
    case Hard = "Hard"
    case Daily = "Daily"
}

struct MainView: View {
    @EnvironmentObject var game: GameController
    @State var curView: ViewType = .Main
    @State var showSubTabBar: Bool = false
    
    var body: some View {
        PopUpView(200, $game.win, {
            popUpView
        }) {
            VStack(spacing: 0) {
                SideBarView(sidebarWidth: 150, showSidebar: $game.showSidebar, sidebar:
                                {
                    sideMenu
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
                            case .Settings:
                                SettingsView()
                                    .environmentObject(game)
                                    .frame(maxWidth: 600, maxHeight: .infinity)
                                    .padding(10)
                            }
                            Spacer()
                        }
                    }
                })
            }
        }
        .environmentObject(game)
    }
}

extension MainView {
    var popUpView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(MyColors.text ,style: StrokeStyle(lineWidth: 1, dash: [5]))
                .background(MyColors.background)
            VStack(alignment: .center) {
                Text("The word was \(game.solution)!")
                    .font(.custom("ChalkboardSE-Light", size: 20))
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(MyColors.text)
                    .padding(10)
                Text("It took you \(game.scores.count) guesses")
                    .font(.custom("ChalkboardSE-Light", size: 15))
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(MyColors.text)
                    .padding(.horizontal, 10)
                Button(action: {
                    if(game.difficulty != .Daily) {
                        game.newGame()
                    } else {
                        shareButton()
                    }
                    game.dismissWinView()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .foregroundColor(MyColors.primary)
                            .cornerRadius(15)
                            .shadow(color: MyColors.shadow, radius: 0, x: 2, y: 2)
                        Text(game.difficulty == .Daily ? "Share" : "Next Word")
                            .font(.custom("ChalkboardSE-Light", size: 20))
                            .foregroundColor(MyColors.text)
                    }
                }
            }
        }
    }
    
    func shareButton() {
        let text = game.shareResultText ?? ""
        let activityController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    
    func transitionDifficulty(_ diff: Difficulty) {
        game.difficulty = diff
        UserDefaults.standard.set(diff.rawValue, forKey: "Difficulty")
        game.showSidebar = false
        showSubTabBar = false
        withAnimation(.default) {
            game.headerOpacity = 1.0
        }
        withAnimation(.default.delay(1.0).speed(0.5)) {
            game.headerOpacity = 0.0
        }
    }
}

extension MainView {
    var sideMenu: some View {
        VStack(spacing: 10) {
            ForEach(ViewType.allCases, id:\.self) { viewType in
                
                if(viewType == .Main) {
                    Button(action: {
                        showSubTabBar = !showSubTabBar
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .aspectRatio(2, contentMode: .fit)
                                .foregroundColor(MyColors.primary)
                            Text(viewType.rawValue)
                                .font(.custom("ChalkboardSE-Light", size: 30))
                                .minimumScaleFactor(0.5)
                                .foregroundColor(MyColors.text)
                        }
                    }.buttonStyle(ScaleButtonStyle())
                    
                    if(showSubTabBar) {
                        VStack(spacing: 10) {
                            ForEach(Difficulty.allCases, id:\.self) { value in
                                SubTabBarTab(diff: value) { [self] in
                                    curView = .Main
                                    if(game.difficulty != value) {
                                        if(value == .Daily) {
                                            game.difficulty = value
                                            game.getWord() {
                                                transitionDifficulty(value)
                                            }
                                        } else {
                                            transitionDifficulty(value)
                                            game.newGame()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .frame(height: 200)
                    }
                } else {
                    Button(action: {
                        curView = viewType
                        game.showSidebar = false
                        showSubTabBar = false
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .aspectRatio(2, contentMode: .fit)
                                .foregroundColor(MyColors.primary)
                            Text(viewType.rawValue)
                                .font(.custom("ChalkboardSE-Light",
                                              size: 30))
                                .minimumScaleFactor(0.5)
                                .foregroundColor(MyColors.text)
                        }
                    }.buttonStyle(ScaleButtonStyle())
                }
            }
            Spacer()
        }
    }
}

struct SubTabBarTab: View {
    var diff: Difficulty
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(MyColors.primary)
                Text(diff.rawValue)
                    .font(.custom("ChalkboardSE-Light", size: 25))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(MyColors.text)
            }
            .frame(maxHeight: .infinity)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(GameController())
    }
}
