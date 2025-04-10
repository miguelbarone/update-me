//
//  UpdateMeApp.swift
//  UpdateMe
//
//  Created by Miguel Barone on 19/12/24.
//

import SwiftUI

@main
struct UpdateMeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ListContentView(viewContext: persistenceController.container.viewContext)
        }
    }
}
