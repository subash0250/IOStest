//
//  projecttestApp.swift
//  projecttest
//
//  Created by Subash Gaddam on 2024-06-27.
//

import SwiftUI
import Firebase

@main
struct projecttestApp: App {
    init() {
            FirebaseApp.configure()
        }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
