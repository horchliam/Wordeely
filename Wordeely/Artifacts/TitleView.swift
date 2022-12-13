//
//  TitleView.swift
//  Wordeely
//
//  Created by Liam Horch on 5/26/22.
//

import SwiftUI
import CoreData

struct TitleView: View {
    @EnvironmentObject var game: GameController
    @State var score = UserDefaults.standard.integer(forKey: "Score")
    
    init() {
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 100) {
            Text("Title View")
                NavigationLink(destination: GameView().environmentObject(game),
                    label: { Text("Play") })
                NavigationLink(destination: StoreView(score: score),
                    label: { Text("Store") })
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView().environmentObject(GameController())
    }
}
