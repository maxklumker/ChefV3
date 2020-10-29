//
//  ChefV3App.swift
//  ChefV3
//
//  Created by Maximilian Klumker on 28.10.20.
//

import SwiftUI
import Firebase

@main
struct ChefV3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

