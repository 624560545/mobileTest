//
//  zmobileTestApp.swift
//  zmobileTest
//
//  Created by 天天 on 2025/9/3.
//

import SwiftUI

@main
struct zmobileTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
