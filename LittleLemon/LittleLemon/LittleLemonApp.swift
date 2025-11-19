//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Amir T Mgr on 19.11.25.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Onboarding().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
