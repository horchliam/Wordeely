//
//  WordeelyApp.swift
//  Wordeely
//
//  Created by Liam Horch on 5/26/22.
//

/* Suggested path of exploring the app...
 
 GameController -> Here -> MainView -> Gameview -> GuessesView -> SideBarView
 
 All other views aren't too bad
 */

import SwiftUI

@main
struct WordeelyApp: App {
    @StateObject var game: GameController = GameController()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        // The start of the app
        WindowGroup {
            MainView()
                .environmentObject(game)
            // For history sake
//            TitleView()
//                .environmentObject(game)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
