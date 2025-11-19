//
//  MainScreen.swift
//  LittleLemon
//
//  Created by Amir T Mgr on 19.11.25.
//

import SwiftUI

struct MainScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            VStack {
                Header()
                Menu()
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
