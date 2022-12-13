//
//  WordeelyApp.swift
//  Wordeely
//
//  Created by Liam Horch on 5/26/22.
//

import SwiftUI

@main
struct WordeelyApp: App {
    @StateObject var game: GameController = GameController()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(game)
//            TitleView()
//                .environmentObject(game)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
