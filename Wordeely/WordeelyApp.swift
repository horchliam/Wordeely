//
//  WordeelyApp.swift
//  Wordeely
//
//  Created by Liam Horch on 5/26/22.
//

import SwiftUI

@main
struct WordeelyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TitleView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
