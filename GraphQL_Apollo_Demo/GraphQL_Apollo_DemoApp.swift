//
//  GraphQL_Apollo_DemoApp.swift
//  GraphQL_Apollo_Demo
//
//  Created by Punit Gupta on 29/08/26.
//

import SwiftUI
//import SwiftData

@main
struct GraphQL_Apollo_DemoApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .modelContainer(sharedModelContainer)
    }
}
